# AGENTS.md - studymaven

## Project Type
- Java Spring MVC Web Application (WAR packaging)
- Built with Maven

## Build Commands
- `mvn clean package` - Build WAR to `target/studymaven.war`
- `mvn compile` - Compile Java sources
- `mvn test` - Run tests (none currently configured)

## Database
- PostgreSQL 연결: `src/main/resources/application.properties`
- DataSource: `applicationContext.xml` 에서 설정

## Key Files
- `pom.xml` - Maven config (Spring 7.0.7, JUnit 3.8.1)
- `src/main/webapp/WEB-INF/web.xml` - Servlet context config
- `src/main/webapp/WEB-INF/dispatcher-servlet.xml` - Spring MVC config
- `src/main/java/com/studymaven/TestController.java` - Controller

## Important Notes
- Component scan in dispatcher-servlet.xml targets `com.studymaven`
- View resolver configured for `/WEB-INF/views/*.jsp`