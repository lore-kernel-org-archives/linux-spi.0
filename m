From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] spi: qup: skip clk_disable_unprepare if the device is
 already runtime suspended
Date: Fri, 2 Sep 2016 09:42:04 +0100
Message-ID: <630dd514-acff-5e83-d638-bda77876ebf2@arm.com>
References: <1472128408-7231-1-git-send-email-sudeep.holla@arm.com>
 <20160901202940.GU5967@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160901202940.GU5967@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi,

On 01/09/16 21:29, Mark Brown wrote:
> On Thu, Aug 25, 2016 at 01:33:28PM +0100, Sudeep Holla wrote:
>> If the spi device is already runtime suspended, if spi_qup_suspend is
>> executed during suspend-to-idle or suspend-to-ram it will result in the
>> following splat:
>>
>> WARNING: CPU: 3 PID: 1593 at drivers/clk/clk.c:476 clk_core_unprepare+0x80/0x90
>> Modules linked in:
>>
>> CPU: 3 PID: 1593 Comm: bash Tainted: G        W       4.8.0-rc3 #14
>> Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
>> PC is at clk_core_unprepare+0x80/0x90
>> LR is at clk_unprepare+0x28/0x40
>> pc : [<ffff0000086eecf0>] lr : [<ffff0000086f0c58>] pstate: 60000145
>
> Please think hard before including complete backtraces in upstream
> reports, they are very large and contain almost no useful information
> relative to their size so often obscure the relevant content in your
> message. If part of the backtrace is usefully illustrative then it's
> usually better to pull out the relevant sections.
>

I removed most of the addresses and just retained the symbols(somehow
the last line with pc and lr was left unintentionally). While you may
have the above opinion, other maintainers may differ. In future, I will
try to add it as a note just to describe the issue.

-- 
Regards,
Sudeep
