From: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] spi: qup: skip clk_disable_unprepare if the device is
 already runtime suspended
Date: Fri, 2 Sep 2016 11:45:08 +0100
Message-ID: <95ff54a3-a776-e4f6-622a-9d88284547ad@arm.com>
References: <1472128408-7231-1-git-send-email-sudeep.holla@arm.com>
 <20160901202940.GU5967@sirena.org.uk>
 <630dd514-acff-5e83-d638-bda77876ebf2@arm.com>
 <20160902093853.GI3950@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andy Gross <andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
        David Brown <david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160902093853.GI3950-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>



On 02/09/16 10:38, Mark Brown wrote:
> On Fri, Sep 02, 2016 at 09:42:04AM +0100, Sudeep Holla wrote:
>> On 01/09/16 21:29, Mark Brown wrote:
>>> On Thu, Aug 25, 2016 at 01:33:28PM +0100, Sudeep Holla wrote:
>
>>>> CPU: 3 PID: 1593 Comm: bash Tainted: G        W       4.8.0-rc3 #14
>>>> Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
>>>> PC is at clk_core_unprepare+0x80/0x90
>>>> LR is at clk_unprepare+0x28/0x40
>>>> pc : [<ffff0000086eecf0>] lr : [<ffff0000086f0c58>] pstate: 60000145
>
>>> Please think hard before including complete backtraces in upstream
>>> reports, they are very large and contain almost no useful information
>>> relative to their size so often obscure the relevant content in your
>>> message. If part of the backtrace is usefully illustrative then it's
>>> usually better to pull out the relevant sections.
>
>> I removed most of the addresses and just retained the symbols(somehow
>> the last line with pc and lr was left unintentionally). While you may
>> have the above opinion, other maintainers may differ. In future, I will
>> try to add it as a note just to describe the issue.
>
> Oh, *that's* why it looked so weird.  Removing the addresses doesn't
> help here, the issue isn't that the addresses are confusing it's that
> you had a tiny commit message dwarfed by the backtrace preamble then a
> screenful of call stack which conveyed no meaningful information,
> including not just the entire callback path for a suspend (which doesn't
> tell us anything really, especially beyond the first frame) and going on
> to show the entire call stack from the sysfs write you used to trigger
> suspend which is even less relevant.
>
> This gives us 30 lines or so of splat (more than a screenful) for five
> lines of actual content with the important bit which describes what the
> change is supposed to be doing buried at the bottom.  That's a really
> bad signal to noise ratio.  What would've been better would be
> explaining why the change you are making fixes the problem.
>

Agreed.

-- 
Regards,
Sudeep
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
