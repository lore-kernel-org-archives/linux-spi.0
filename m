From: Akash Asthana <akashast@codeaurora.org>
Subject: Re: [PATCH 1/6] soc: qcom: geni: Support for ICC voting
Date: Wed, 19 Feb 2020 18:55:02 +0530
Message-ID: <65e59f55-4c84-d73b-10b5-be11fb7293be@codeaurora.org>
References: <1581946205-27189-1-git-send-email-akashast@codeaurora.org>
 <1581946205-27189-2-git-send-email-akashast@codeaurora.org>
 <20200218030310.GV955802@ripper>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: gregkh@linuxfoundation.org, agross@kernel.org, wsa@the-dreams.de,
        broonie@kernel.org, mark.rutland@arm.com, robh+dt@kernel.org,
        linux-i2c@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, swboyd@chromium.org,
        mgautam@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, mka@chromium.org,
        dianders@chromium.org
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <20200218030310.GV955802@ripper>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Bjorn,

>>   	struct clk *clk;
>>   	unsigned int num_clk_levels;
>>   	unsigned long *clk_perf_tbl;
>> +	struct icc_path *icc_path[3];
> In all cases you refer to icc_path[IDENIFIER], so just give the three
> paths individual members and drop the enum above.
>
> Reards,
> Bjorn

Ok

Thanks for reviewing.

Regards,

Akash

>
>> +	unsigned int avg_bw_core;
>> Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project
