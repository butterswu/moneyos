package ssm.dao;

import org.springframework.stereotype.Repository;
import ssm.model.UserLevel;

@Repository
public interface UserLevelDao {
    UserLevel getUserLevelById(int userLevelId);

}
