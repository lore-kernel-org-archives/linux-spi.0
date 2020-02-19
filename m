From: Akash Asthana <akashast@codeaurora.org>
Subject: Re: [PATCH 2/6] tty: serial: qcom_geni_serial: Add interconnect
 support
Date: Wed, 19 Feb 2020 19:01:49 +0530
Message-ID: <ecf58973-ab26-3363-d934-6c83e8bbec24@codeaurora.org>
References: <1581946205-27189-1-git-send-email-akashast@codeaurora.org>
 <1581946205-27189-3-git-send-email-akashast@codeaurora.org>
 <20200218223450.GE15781@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: gregkh@linuxfoundation.org, agross@kernel.org,
        bjorn.andersson@linaro.org, wsa@the-dreams.de, broonie@kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org,
        linux-i2c@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, swboyd@chromium.org,
        mgautam@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, dianders@chromium.org
To: Matthias Kaehlcke <mka@chromium.org>
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20200218223450.GE15781@google.com>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Matthias,

On 2/19/2020 4:04 AM, Matthias Kaehlcke wrote:
> On Mon, Feb 17, 2020 at 07:00:01PM +0530, Akash Asthana wrote:
>> Get the interconnect paths for Uart based Serial Engine device
>> and vote according to the baud rate requirement of the driver.
>>
>> Signed-off-by: Akash Asthana <akashast@codeaurora.org>
>> ---
>>
>> +	port->se.avg_bw_cpu = Bps_to_icc(1000);
>> +	port->se.avg_bw_cpu = Bps_to_icc(1000);
> I guess you mean 'peak_bw_cpu'?

Yes I meant peak_bw_cpu here, i will correct it in next version.

Regards,

Akash

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project
