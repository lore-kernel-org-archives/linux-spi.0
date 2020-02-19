From: Akash Asthana <akashast@codeaurora.org>
Subject: Re: [PATCH 6/6] arm64: dts: sc7180: Add interconnect for QUP and QSPI
Date: Wed, 19 Feb 2020 19:19:11 +0530
Message-ID: <f82a28c7-63a4-b0e8-3902-5614dfed0f78@codeaurora.org>
References: <1581946205-27189-1-git-send-email-akashast@codeaurora.org>
 <1581946205-27189-7-git-send-email-akashast@codeaurora.org>
 <20200218031830.GX955802@ripper>
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
In-Reply-To: <20200218031830.GX955802@ripper>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Bjorn,

>> +				interconnects = <&qup_virt MASTER_QUP_CORE_0
>> +						&qup_virt SLAVE_QUP_CORE_0>,
>> +						<&gem_noc MASTER_APPSS_PROC
>> +						&config_noc SLAVE_QUP_0>,
>> +						<&aggre1_noc MASTER_QUP_0
>> +						&mc_virt SLAVE_EBI1>;
> Please ignore the 80-char "limit" and write this as:
> 				interconnects = <&qup_virt MASTER_QUP_CORE_0 &qup_virt SLAVE_QUP_CORE_0>,
> 						<&gem_noc ...>,
> 						<&aggre1_noc ...>;
>
> Regards,
> Bjorn

ok

Regards,

Akash

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project
