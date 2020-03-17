From: Akash Asthana <akashast@codeaurora.org>
Subject: Re: [PATCH V2 6/8] spi: spi-geni-qcom: Add interconnect support
Date: Tue, 17 Mar 2020 15:05:21 +0530
Message-ID: <aa197568-3bac-6962-d39d-3261f68c0514@codeaurora.org>
References: <1584105134-13583-1-git-send-email-akashast@codeaurora.org>
 <1584105134-13583-7-git-send-email-akashast@codeaurora.org>
 <20200313131603.GG5528@sirena.org.uk>
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
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20200313131603.GG5528@sirena.org.uk>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


On 3/13/2020 6:46 PM, Mark Brown wrote:
> On Fri, Mar 13, 2020 at 06:42:12PM +0530, Akash Asthana wrote:
>
>> +	se->avg_bw_cpu = Bps_to_icc(mas->cur_speed_hz);
>> +	se->peak_bw_cpu = Bps_to_icc(2 * mas->cur_speed_hz);
> As I commented on the previous version to no reply there seem to be a
> lot of cases where the peak bandwidth is just set to double the normal
> bandwidth without obvious analysis.  Should this default be centralized?

Hi Mark,

I misunderstood previous comment on V1 
patch@https://patchwork.kernel.org/patch/11386479/ as a suggestion to 
mention comment for peak BW choice if nothing mentioned explicitly (in 
this case I mentioned assume peak BW twice as average).

I understand in any case I should have ack'ed the comment atleast by 
replying "ok". I am sorry about it.


We are taking care of actual throughput requirement in avg_bw vote and 
the intention of putting peak as twice of avg is to ensure that if high 
speed peripherals(ex:USB) removes their votes, we shouldn't see any 
latency issue because of other ICC client who don't vote for their BW 
requirement or *actual* BW requirement. Factor of 2 is chosen randomly. 
Please correct/improve me if this is not okay.

If this is okay, I will centralize this design for SPI QUP, I2C and UART 
driver.

Regards,

Akash



-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project
