package ssm.model;

public class Results {
    private String answerTime;
    private String callMode;
    private String callStatus;
    private String callType;
    private String callee;
    private String calleeAppType;
    private String calleeAppVersion;
    private String caller;
    private String callerAppType;
    private String callerAppVersion;
    private String deptId;
    private String deptName;
    private String duration;
    private String empAccount;
    private String empEmail;
    private String empId;
    private String empName;
    private String endTime;
    private String recordId;
    private String recordingUrl;
    private String source;
    private String startTime;
    private String totalDuration;

    @Override
    public String toString() {
        return "Results{" +
                "answerTime='" + answerTime + '\'' +
                ", callMode='" + callMode + '\'' +
                ", callStatus='" + callStatus + '\'' +
                ", callType='" + callType + '\'' +
                ", callee='" + callee + '\'' +
                ", calleeAppType='" + calleeAppType + '\'' +
                ", calleeAppVersion='" + calleeAppVersion + '\'' +
                ", caller='" + caller + '\'' +
                ", callerAppType='" + callerAppType + '\'' +
                ", callerAppVersion='" + callerAppVersion + '\'' +
                ", deptId='" + deptId + '\'' +
                ", deptName='" + deptName + '\'' +
                ", duration='" + duration + '\'' +
                ", empAccount='" + empAccount + '\'' +
                ", empEmail='" + empEmail + '\'' +
                ", empId='" + empId + '\'' +
                ", empName='" + empName + '\'' +
                ", endTime='" + endTime + '\'' +
                ", recordId='" + recordId + '\'' +
                ", recordingUrl='" + recordingUrl + '\'' +
                ", source='" + source + '\'' +
                ", startTime='" + startTime + '\'' +
                ", totalDuration='" + totalDuration + '\'' +
                '}';
    }

    public String getAnswerTime() {
        return answerTime;
    }

    public void setAnswerTime(String answerTime) {
        this.answerTime = answerTime;
    }

    public String getCallMode() {
        return callMode;
    }

    public void setCallMode(String callMode) {
        this.callMode = callMode;
    }

    public String getCallStatus() {
        return callStatus;
    }

    public void setCallStatus(String callStatus) {
        this.callStatus = callStatus;
    }

    public String getCallType() {
        return callType;
    }

    public void setCallType(String callType) {
        this.callType = callType;
    }

    public String getCallee() {
        return callee;
    }

    public void setCallee(String callee) {
        this.callee = callee;
    }

    public String getCalleeAppType() {
        return calleeAppType;
    }

    public void setCalleeAppType(String calleeAppType) {
        this.calleeAppType = calleeAppType;
    }

    public String getCalleeAppVersion() {
        return calleeAppVersion;
    }

    public void setCalleeAppVersion(String calleeAppVersion) {
        this.calleeAppVersion = calleeAppVersion;
    }

    public String getCaller() {
        return caller;
    }

    public void setCaller(String caller) {
        this.caller = caller;
    }

    public String getCallerAppType() {
        return callerAppType;
    }

    public void setCallerAppType(String callerAppType) {
        this.callerAppType = callerAppType;
    }

    public String getCallerAppVersion() {
        return callerAppVersion;
    }

    public void setCallerAppVersion(String callerAppVersion) {
        this.callerAppVersion = callerAppVersion;
    }

    public String getDeptId() {
        return deptId;
    }

    public void setDeptId(String deptId) {
        this.deptId = deptId;
    }

    public String getDeptName() {
        return deptName;
    }

    public void setDeptName(String deptName) {
        this.deptName = deptName;
    }

    public String getDuration() {
        return duration;
    }

    public void setDuration(String duration) {
        this.duration = duration;
    }

    public String getEmpAccount() {
        return empAccount;
    }

    public void setEmpAccount(String empAccount) {
        this.empAccount = empAccount;
    }

    public String getEmpEmail() {
        return empEmail;
    }

    public void setEmpEmail(String empEmail) {
        this.empEmail = empEmail;
    }

    public String getEmpId() {
        return empId;
    }

    public void setEmpId(String empId) {
        this.empId = empId;
    }

    public String getEmpName() {
        return empName;
    }

    public void setEmpName(String empName) {
        this.empName = empName;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    public String getRecordId() {
        return recordId;
    }

    public void setRecordId(String recordId) {
        this.recordId = recordId;
    }

    public String getRecordingUrl() {
        return recordingUrl;
    }

    public void setRecordingUrl(String recordingUrl) {
        this.recordingUrl = recordingUrl;
    }

    public String getSource() {
        return source;
    }

    public void setSource(String source) {
        this.source = source;
    }

    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    public String getTotalDuration() {
        return totalDuration;
    }

    public void setTotalDuration(String totalDuration) {
        this.totalDuration = totalDuration;
    }
}
