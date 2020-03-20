From: Akash Asthana <akashast@codeaurora.org>
Subject: Re: [PATCH V2 6/8] spi: spi-geni-qcom: Add interconnect support
Date: Fri, 20 Mar 2020 19:22:17 +0530
Message-ID: <58116473-1d9e-d08a-8839-a39dd0ee32bf@codeaurora.org>
References: <1584105134-13583-1-git-send-email-akashast@codeaurora.org>
 <1584105134-13583-7-git-send-email-akashast@codeaurora.org>
 <20200313131603.GG5528@sirena.org.uk>
 <aa197568-3bac-6962-d39d-3261f68c0514@codeaurora.org>
 <20200317130616.GE3971@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: gregkh@linuxfoundation.org, agross@kernel.org,
        bjorn.andersson@linaro.org, wsa@the-dreams.de,
        mark.rutland@arm.com, robh+dt@kernel.org,
        linux-i2c@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, swboyd@chromium.org,
        mgautam@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, mka@chromium.org,
        dianders@chromium.org, evgreen@chromium.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <20200317130616.GE3971@sirena.org.uk>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Mark,

On 3/17/2020 6:36 PM, Mark Brown wrote:
> On Tue, Mar 17, 2020 at 03:05:21PM +0530, Akash Asthana wrote:
>
>> We are taking care of actual throughput requirement in avg_bw vote and the
>> intention of putting peak as twice of avg is to ensure that if high speed
>> peripherals(ex:USB) removes their votes, we shouldn't see any latency issue
>> because of other ICC client who don't vote for their BW requirement or
>> *actual* BW requirement. Factor of 2 is chosen randomly. Please
>> correct/improve me if this is not okay.
>> If this is okay, I will centralize this design for SPI QUP, I2C and UART
>> driver.
> That seems reasonable to me, it was just the fact that every driver
> seemed to be doing the same thing that I was noticing - what was being
> done seemed OK.

Okay, thanks for confirming I will keep as is.

Regards,

Akash

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project
