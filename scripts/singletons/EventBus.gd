extends Node

class EventSubscription:
	var event: String
	var callback: Callable
	var owner: Object = null

var _listeners: Dictionary = {}

func subscribe(event: String, callback: Callable) -> void:
	if not _listeners.has(event):
		_listeners[event] = []
	
	var subscription = EventSubscription.new()
	subscription.event = event
	subscription.callback = callback
	subscription.owner = owner
	
	_listeners[event].append(subscription)

## Отписка от конкретного события
func unsubscribe(event: String, callback: Callable) -> void:
	if not _listeners.has(event):
		return
	
	_listeners[event] = _listeners[event].filter(
		func(sub): return sub.callback != callback
	)

## Отписка от всех событий для конкретного владельца
func unsubscribe_all() -> void:
	for event in _listeners:
		_listeners[event] = _listeners[event].filter(
			func(sub): return sub.owner != owner
		)

## Отправка события
func emit(event: String, data: Dictionary = {}) -> void:
	if not _listeners.has(event):
		return
	
	# Создаём копию списка на случай модификации во время итерации
	var listeners_copy = _listeners[event].duplicate()
	
	for subscription in listeners_copy:
		# Проверяем валидность владельца перед вызовом
		if subscription.owner == null or is_instance_valid(subscription.owner):
			subscription.callback.call(data)

## Получить количество подписчиков на событие
func get_listener_count(event: String) -> int:
	if not _listeners.has(event):
		return 0
	return _listeners[event].size()

## Очистить всех подписчиков события
func clear_event(event: String) -> void:
	_listeners.erase(event)

## Очистить всех подписчиков всех событий
func clear_all() -> void:
	_listeners.clear()
