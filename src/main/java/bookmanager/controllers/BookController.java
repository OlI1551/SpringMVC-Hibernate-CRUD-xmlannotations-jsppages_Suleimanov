package bookmanager.controllers;

import bookmanager.models.Book;
import bookmanager.services.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Controller
public class BookController {
    private BookService bookService;

    private static final Logger logger = LoggerFactory.getLogger(BookController.class);

    @Autowired(required = true)
    @Qualifier(value = "bookService")
    public void setBookService(BookService bookService) {
        this.bookService = bookService;
    }

    @RequestMapping(value = "/books", method = RequestMethod.GET)
    public String listBooks(Model model
//            , HttpSession session
    ) {
        Book book = new Book();
        model.addAttribute("book", book);
//        session.setAttribute("book", book);
        logger.info("Fetching list of books from the database...");
        List<Book> listBooks = this.bookService.listBooks();
        logger.info("Number of books fetched: {}", listBooks.size());
        model.addAttribute("listBooks", listBooks);
        logger.info("List of books added to the model.");
//        session.setAttribute("listBooks", listBooks);

        return "books";
    }

    @RequestMapping(value = "/books/add", method = RequestMethod.POST)
    public String addBook(@ModelAttribute("book") Book book) {
        if (book.getId() == 0) {
            this.bookService.addBook(book);
        } else {
            this.bookService.updateBook(book);
        }

        return "redirect:/books";
    }

    @RequestMapping("/remove/{id}")
    public String removeBook(@PathVariable("id") int id) {
        this.bookService.removeBook(id);

        return "redirect:/books";
    }

    @RequestMapping("/edit/{id}")
    public String editBook(@PathVariable("id") int id, Model model) {
        model.addAttribute("book", this.bookService.getBookById(id));
        model.addAttribute("listBooks", this.bookService.listBooks());

        return "books";
    }

    @RequestMapping("/bookdata/{id}")
    public String bookData(@PathVariable("id") int id, Model model) {
        model.addAttribute("book", this.bookService.getBookById(id));

        return "bookdata";
    }
}