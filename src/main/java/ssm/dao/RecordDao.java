package ssm.dao;


import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import ssm.model.Record;
import ssm.model.Results;

import java.util.List;

@Repository
public interface RecordDao {
    List<Record> getRecordByManId(int id);
    void newRecord(Record record);
    void addFjs(@Param("r") Results results);
}
