package ssm.service;

import org.springframework.ui.Model;
import ssm.model.Manager;
import ssm.model.Page;
import ssm.model.Record;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

public interface ManagerService {
    void showManagerByPage(HttpServletRequest request, Model model);
    void getManagerById(HttpServletRequest request, Model model);
    void updateManagerById(HttpServletRequest request, Model model,Manager manager);
    void newRecord(HttpServletRequest request, Model model, Record record);
    void newManager(HttpServletRequest request, Model model,Manager manager);
    Page ajaxgetManagerByPage(HttpServletRequest request,Model model);
}