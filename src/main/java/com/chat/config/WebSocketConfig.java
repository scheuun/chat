package com.chat.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;

@Configuration
@EnableWebSocketMessageBroker
public class WebSocketConfig implements WebSocketMessageBrokerConfigurer {
    // WebSocket 엔드포인트 정의
    @Override
    public void registerStompEndpoints (StompEndpointRegistry registry) {
        // Websocket Url 경로, WebSocket +는 모든 원본 허용, WebSocket 연결 수락
        registry.addEndpoint("/").setAllowedOrigins("+").withSockJS();
    }
}
