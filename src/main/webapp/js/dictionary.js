/*系统字典翻译*/
/*学历*/
var degree = {};
$.getJSON(base + '/dict/findDict/degree', function (json) {
    degree = json;
});
function degreeFormatter(value) {
    for (var i = 0; i < degree.length; i++) {
        if (degree[i].value == value) {
            return degree[i].name;
        }
    }
    return value;
}

/*性别*/
var Sex = {};
$.getJSON(base + '/dict/findDict/Sex', function (json) {
    Sex = json;
});
function SexFormatter(value) {
    //alert(Sex.length);
    for (var i = 0; i < Sex.length; i++) {
        if (Sex[i].value == value) {
            return Sex[i].name;
        }
    }
    return value;
}

/*机智应变能力*/
var StrainAbility = {};
$.getJSON(base + '/dict/findDict/StrainAbility', function (json) {
    StrainAbility = json;
});
function StrainAbilityFormatter(value) {
    for (var i = 0; i < StrainAbility.length; i++) {
        if (StrainAbility[i].value == value) {
            return StrainAbility[i].name;
        }
    }
    return value;
}

/*能力等级*/
var abilityLevel = {};
$.getJSON(base + '/dict/findDict/abilityLevel', function (json) {
    abilityLevel = json;
});
function abilityLevelFormatter(value) {
    for (var i = 0; i < abilityLevel.length; i++) {
        if (abilityLevel[i].value == value) {
            return abilityLevel[i].name;
        }
    }
    return value;
}

/*优秀程度*/
var excellence = {};
$.getJSON(base + '/dict/findDict/excellence', function (json) {
    excellence = json;
});
function excellenceFormatter(value) {
    for (var i = 0; i < excellence.length; i++) {
        if (excellence[i].value == value) {
            return excellence[i].name;
        }
    }
    return value;
}

/*是否同意录取*/
var hiring = {};
$.getJSON(base + '/dict/findDict/hiring', function (json) {
    hiring = json;
});
function hiringFormatter(value) {
    for (var i = 0; i < hiring.length; i++) {
        if (hiring[i].value == value) {
            return hiring[i].name;
        }
    }
    return value;
}

/*精神面貌*/
var impression2 = {};
$.getJSON(base + '/dict/findDict/impression2', function (json) {
    impression2 = json;
});
function impression2Formatter(value) {
    for (var i = 0; i < impression2.length; i++) {
        if (impression2[i].value == value) {
            return impression2[i].name;
        }
    }
    return value;
}


/*情绪和自信心*/
var impression3 = {};
$.getJSON(base + '/dict/findDict/impression3', function (json) {
    impression3 = json;
});
function impression3Formatter(value) {
    for (var i = 0; i < impression3.length; i++) {
        if (impression3[i].value == value) {
            return impression3[i].name;
        }
    }
    return value;
}

/*入职状态*/
var inductionStatus = {};
$.getJSON(base + '/dict/findDict/inductionStatus', function (json) {
    inductionStatus = json;
});
function inductionStatusFormatter(value) {
    for (var i = 0; i < inductionStatus.length; i++) {
        if (inductionStatus[i].value == value) {
            return inductionStatus[i].name;
        }
    }
    return value;
}

/*行业经验*/
var industryExperience = {};
$.getJSON(base + '/dict/findDict/industryExperience', function (json) {
    industryExperience = json;
});
function industryExperienceFormatter(value) {
    for (var i = 0; i < industryExperience.length; i++) {
        if (industryExperience[i].value == value) {
            return industryExperience[i].name;
        }
    }
    return value;
}

/*工作稳定性*/
var jobStability = {};
$.getJSON(base + '/dict/findDict/jobStability', function (json) {
    jobStability = json;
});
function jobStabilityFormatter(value) {
    for (var i = 0; i < jobStability.length; i++) {
        if (jobStability[i].value == value) {
            return jobStability[i].name;
        }
    }
    return value;
}

/*对知识的了解程度*/
var knowledge = {};
$.getJSON(base + '/dict/findDict/knowledge', function (json) {
    knowledge = json;
});
function knowledgeFormatter(value) {
    for (var i = 0; i < knowledge.length; i++) {
        if (knowledge[i].value == value) {
            return knowledge[i].name;
        }
    }
    return value;
}

/*逻辑思维能力*/
var logicalAbility = {};
$.getJSON(base + '/dict/findDict/logicalAbility', function (json) {
    logicalAbility = json;
});
function logicalAbilityFormatter(value) {
    for (var i = 0; i < logicalAbility.length; i++) {
        if (logicalAbility[i].value == value) {
            return logicalAbility[i].name;
        }
    }
    return value;
}

/*契合程度*/
var matchDegree = {};
$.getJSON(base + '/dict/findDict/matchDegree', function (json) {
    matchDegree = json;
});
function matchDegreeFormatter(value) {
    for (var i = 0; i < matchDegree.length; i++) {
        if (matchDegree[i].value == value) {
            return matchDegree[i].name;
        }
    }
    return value;
}

/*政治面貌*/
var political = {};
$.getJSON(base + '/dict/findDict/political', function (json) {
    political = json;
});
function politicalFormatter(value) {
    for (var i = 0; i < political.length; i++) {
        if (political[i].value == value) {
            return political[i].name;
        }
    }
    return value;
}

/*面试意见*/
var preliminary = {};
$.getJSON(base + '/dict/findDict/preliminary', function (json) {
    preliminary = json;
});
function preliminaryFormatter(value) {
    for (var i = 0; i < preliminary.length; i++) {
        if (preliminary[i].value == value) {
            return preliminary[i].name;
        }
    }
    return value;
}

/*是否*/
var updatable = {};
$.getJSON(base + '/dict/findDict/updatable', function (json) {
    updatable = json;
});
function updatableFormatter(value) {
    for (var i = 0; i < updatable.length; i++) {
        if (updatable[i].value == value) {
            return updatable[i].name;
        }
    }
    return value;
}
//添加离职管理模块参数  kxl  20151026
/*离职原因*/
var dimissionReason = {};
$.getJSON(base + '/dict/findDict/dimissionReason', function (json) {
    dimissionReason = json;
});
function dimissionReasonFormatter(value) {
    for (var i = 0; i < dimissionReason.length; i++) {
        if (dimissionReason[i].value == value) {
            return dimissionReason[i].name;
        }
    }
    return value;
}
/*离职类型*/
var dimissionType = {};
$.getJSON(base + '/dict/findDict/dimissionType', function (json) {
    dimissionType = json;
});
function dimissionTypeFormatter(value) {
    for (var i = 0; i < dimissionType.length; i++) {
        if (dimissionType[i].value == value) {
            return dimissionType[i].name;
        }
    }
    return value;
}
/*离职申请状态*/
var Dimission = {};
$.getJSON(base + '/dict/findDict/Dimission', function (json) {
    Dimission = json;
});
function DimissionFormatter(value) {
    for (var i = 0; i < Dimission.length; i++) {
        if (Dimission[i].value == value) {
            return Dimission[i].name;
        }
    }
    return value;
}

/*面谈结果*/
var Interview = {};
$.getJSON(base + '/dict/findDict/Interview', function (json) {
    Interview = json;
});
function InterviewFormatter(value) {
    for (var i = 0; i < Interview.length; i++) {
        if (Interview[i].value == value) {
            return Interview[i].name;
        }
    }
    return value;
}

/*面谈处理方式*/
var processMode = {};
$.getJSON(base + '/dict/findDict/processMode', function (json) {
    processMode = json;
});
function processModeFormatter(value) {
    for (var i = 0; i < processMode.length; i++) {
        if (processMode[i].value == value) {
            return processMode[i].name;
        }
    }
    return value;
}



