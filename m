From: Akash Asthana <akashast@codeaurora.org>
Subject: Re: [PATCH 0/6] Add interconnect support to UART, I2C, SPI and QSPI
Date: Wed, 11 Mar 2020 18:32:44 +0530
Message-ID: <9e0afe90-5480-2db5-48fb-39cd8db6e8d1@codeaurora.org>
References: <1581946205-27189-1-git-send-email-akashast@codeaurora.org>
 <20200309175954.GX24720@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Cc: gregkh@linuxfoundation.org, agross@kernel.org,
        bjorn.andersson@linaro.org, wsa@the-dreams.de, broonie@kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org,
        linux-i2c@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, swboyd@chromium.org,
        mgautam@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, dianders@chromium.org,
        evgreen@chromium.org
To: Matthias Kaehlcke <mka@chromium.org>
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20200309175954.GX24720@google.com>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


On 3/9/2020 11:29 PM, Matthias Kaehlcke wrote:
> Hi Akash,
>
> do you plan to re-spin this series in the near future?
>
> Thanks
>
> Matthias

Hi  Matthias,

I will re-spin the series by 3/13.

Regards,

Akash

>
> On Mon, Feb 17, 2020 at 06:59:59PM +0530, Akash Asthana wrote:
>> dt-binding patch for UART, I2C and SPI.
>>   - https://patchwork.kernel.org/patch/11385965/ [Convert QUP bindings
>> 	to YAML and add ICC, pin swap doc]
>>
>> dt-binding patch for QSPI.
>>   - https://patchwork.kernel.org/cover/11386003/ [Convert QSPI binding
>> 	to YAML and add interconnect doc]
>>
>> Akash Asthana (6):
>>    soc: qcom: geni: Support for ICC voting
>>    tty: serial: qcom_geni_serial: Add interconnect support
>>    i2c: i2c-qcom-geni: Add interconnect support
>>    spi: spi-geni-qcom: Add interconnect support
>>    spi: spi-qcom-qspi: Add interconnect support
>>    arm64: dts: sc7180: Add interconnect for QUP and QSPI
>>
>>   arch/arm64/boot/dts/qcom/sc7180.dtsi  | 199 ++++++++++++++++++++++++++++++++++
>>   drivers/i2c/busses/i2c-qcom-geni.c    |  84 +++++++++++++-
>>   drivers/spi/spi-geni-qcom.c           |  65 ++++++++++-
>>   drivers/spi/spi-qcom-qspi.c           |  38 ++++++-
>>   drivers/tty/serial/qcom_geni_serial.c |  84 ++++++++++++--
>>   include/linux/qcom-geni-se.h          |  31 ++++++
>>   6 files changed, 481 insertions(+), 20 deletions(-)
>>
>> -- 
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project
