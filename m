From: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2, 1/1] mtd: devices: m25p80: Add PM suspend resume support
Date: Fri, 20 Jan 2017 20:36:56 +0100
Message-ID: <CAOMqctSPAQAjkSzcMY_7prvPpX7c_BqTTxd3ixPEZNd0tcwH3A@mail.gmail.com>
References: <1473710494-4084-1-git-send-email-kdasu.kdev@gmail.com>
 <4fe502a4-ee01-3fb8-6697-161de814596e@atmel.com> <CAKekbeubczM5NpQy-Umqx-SmDM+deMcgYciyST2Sgrh2_dOsAw@mail.gmail.com>
 <c9198202-29d1-5e67-f675-5a53d926ede9@atmel.com> <fa44881d-701b-195a-9617-239454645183@gmail.com>
 <CAC=U0a3HRrx+0Y8YGSiDdfEigkQGa-QxHJ53tK1-Yo-iTj=yXA@mail.gmail.com>
 <af540565-2347-4f51-a5a7-e65f3d26c258@denx.de> <CAC=U0a3Q_dBefFayi4G2TueZNXYAhdakduSwYdKPxDDL5Uoi_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>,
        Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Jayachandran C <jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Marek Vasut <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
        MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
        Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Kamal Dasu <kamal.dasu-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
To: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAC=U0a3Q_dBefFayi4G2TueZNXYAhdakduSwYdKPxDDL5Uoi_A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hello,

On 20 January 2017 at 19:50, Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On Fri, Jan 20, 2017 at 12:22 PM, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org> wrote:
>> On 01/20/2017 05:33 PM, Kamal Dasu wrote:
>>> Marek,
>>>
>>>>>
>>>>> OK, so I'm fine with leaving the patch as is for now but I would like Marek
>>>>> review just to be sure we didn't miss something: Marek, any comments?
>>>>>
>>>>> I just have one more comment below but it's only a detail.
>>>>
>>>> What would happen if you have a FS attached on this SPI NOR (like UBIFS)
>>>> and you suspend with this patch ? Will it survive ?
>>>>
>>>>
>>>
>>> I have tried with both jffs2 rw and ubifs rw rootfs on spi-nor
>>> booting from spi-nor partitions while  active filesystem operations
>>> were going on over suspend/resume cycles. And it survives.
>>
>> Can you elaborate on your test a bit ?
>>
>
> The power management test  puts  board in standby mode,  during
> standby the DRAM is in refresh and power to the spi-nor is removed.
> After a set timeout the board wakes up again and resumes from where it
> left off. This pm test is run while a cp command is invoked where a
> file is transferred to the rw rootfs. The test loops through said
> number of iterations of suspend and resumes cycles. The copy
> operations is eventually done over a few cycles. Once the test is
> completed  filesystem should have no corruptions, the copied files
> should compare and rootfs should be intact.  This test was repeated
> with jffs2 as well as ubifs rootfs flashed on spi-nor device.

Can some problem arise from not cutting the power in some situation?

Presumably with this patch the system tries to re-initialize the SPI NOR
after resume from suspend.

Can some SPI NOR memories be programmed into state in which they
would not respond to the commands used for identify?

Perhaps flash memories in dual/quad mode should be switched to plain
mode first?

Thanks

Michal
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
