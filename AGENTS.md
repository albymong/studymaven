# AGENTS.md – studymaven

## Build & Test
- `mvn clean package` → builds `target/studymaven.war`
- `mvn compile` → quick compile check after code changes
- Run a single JUnit test: `mvn -Dtest=ClassName#methodName test`

## Configuration
- DB properties in `src/main/resources/application.properties` (`jdbc.username`, `jdbc.password`).
- File upload directory is read from the `file.upload.dir` property – no hard‑coded paths.

## Architecture (package → role)
- Controllers: `com.studymaven.controller`
- Services: `com.studymaven.service`
- MyBatis Mappers: `com.studymaven.mapper`
- Domain/DTOs: `com.studymaven.domain`

## Board feature (CRUD + file attachments)
- List  `GET /board` → `board/list.jsp`
- Write `GET /board/write` → `board/write.jsp`
-  POST `/board/write` **must** use `enctype="multipart/form-data"`
- View `GET /board/view/{id}` → `board/view.jsp`
- Edit `GET /board/edit/{id}` → `board/edit.jsp`
-  POST `/board/edit/{id}` handles file updates
- Delete `POST /board/delete/{id}`
- Max 10 uploaded files per post (enforced in `BoardController`)

## File upload / download flow
- Upload directory: value of `file.upload.dir`
- DB table `board_file` columns: `id, board_id, original_name, stored_name, file_size`
- Upload steps:
  1. multipart form posts to `BoardController`
  2. `BoardService.saveFiles()` stores on disk & inserts rows
  3. `BoardController.viewPage()` calls `service.getFiles(id)` for display
- Download steps:
  1. `GET /download/prepare?fileId={id}` → confirmation page
  2. `GET /download/execute?fileId={id}` → streams file with RFC 5987‑encoded UTF‑8 filename

## Gotchas
- All upload forms **must** set `enctype="multipart/form-data"`.
- `BoardMapper.xml` INSERT needs `useGeneratedKeys="true"` and `keyProperty="id"`.
- Flash messages are added via `RedirectAttributes.addFlashAttribute("message", …)`; JSPs must include `<c:if test="${not empty message}">` to render them.
- Date display: ≤ 7 days → `yyyy‑MM‑dd HH:mm`; older → `yyyy‑MM‑dd`.
- XSS protection: always output user‑supplied data with `<c:out value="..."/>`.

## Key service/mapper methods
- `BoardService.create(vo, writerId, files)` – create board + save files
- `BoardService.update(vo, files)` – update board, replace files if supplied
- `BoardService.getFiles(boardId)` – list `BoardFileVO`
- `BoardService.getFileById(fileId)` – single file for download
- `BoardMapper.selectFiles(boardId)` – DB query for files
- `BoardMapper.insertFile(fileVO)` – insert into `board_file`

## Reference
- Project‑level AI guidelines: `AI_PRINCIPLES.md`
