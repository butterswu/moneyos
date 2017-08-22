package ssm.dao;


import org.springframework.stereotype.Repository;
import ssm.model.Record;

import java.util.List;

@Repository
public interface RecordDao {
    List<Record> getRecordByManId(int id);
    void newRecord(Record record);

}
