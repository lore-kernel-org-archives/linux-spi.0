From: Vignesh Raghavendra <vigneshr-l0cyMroinI0@public.gmane.org>
Subject: Re: [EXT] Re: [PATCH v6 0/2] spi: cadence-quadpsi: Add support for
 the Cadence QSPI controller
Date: Mon, 27 Jan 2020 09:51:28 +0530
Message-ID: <3afe0dde-02f7-8f75-4410-efbdb5f91499@ti.com>
References: <20191230074102.50982-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <860aecbc-22d3-c9ce-3570-44115d6e81b2@ti.com>
 <AM0PR0402MB355668F205AD711D2059CDB5E00F0@AM0PR0402MB3556.eurprd04.prod.outlook.com>
 <40ee10f1-0b30-155c-c165-1baa57a22109@ti.com>
 <AM6PR0402MB35573B2313C7FB81D747ABA6E00F0@AM6PR0402MB3557.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org" <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>,
        "cheol.yong.kim-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <cheol.yong.kim-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
        "qi-ming.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <qi-ming.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
To: Kuldeep Singh <kuldeep.singh-3arQi8VN3Tc@public.gmane.org>,
        "Ramuthevar,Vadivel MuruganX"
        <vadivel.muruganx.ramuthevar-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        "broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AM6PR0402MB35573B2313C7FB81D747ABA6E00F0-Dzj3fuf2f4AsyWmSStHLuo3W/0Ik+aLCnBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi,

On 23/01/20 5:07 pm, Kuldeep Singh wrote:
> Hi Vignesh,
> 
[...]
>> I did test with s25fl512s with UBIFS and did not see any issue. 
> 
> Thanks Vignesh for this confirmation.
> 
>> Could you try with latest linux master or linux next? There were couple of fixes in the last -rc
>> related to spansion flashes?
> 
> Yes, I have already applied those patches and still facing this issue.
> I am testing with s25fs512s and only able to make it work on 1bit mode and that too by skipping SFDP.

Hmm, why would you need to skip SFDP parsing in 1 bit mode? What
actually fails when SFDP is parsed? Read/write/erase? BTW, did s25fs512s
flash ever with you controller before (i.e is this a regression)?

> Basic read/write works on other modes but not FS utilities.
> Could you please share any pointer to look into which direction. Thanks in advance.
> 

If 1 bit mode works fine, then probably flash FS in 1 bit mode and they
try read only mount in quad mode. Thus try and narrow down if the issue
is in read path vs write path.

Regards
Vignesh

> Thanks
> Kuldeep
> 
>>
>> [1]
>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kerne
>> l.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fmtd%2Flinux.git%2Fcommit
>> %2F%3Fh%3Dmtd%2Ffixes%26id%3D440b6d50254bdbd84c2a665c7f53ec69dd
>> 741a4f&amp;data=02%7C01%7Ckuldeep.singh%40nxp.com%7Cee345bdf9f654
>> 4ac9f4508d79fd863d9%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7
>> C637153624041330774&amp;sdata=OyKGl2jn5JDq5KCaVrxAnUh4qSynmAhS%
>> 2FeFiOxJSKtU%3D&amp;reserved=0
>> [2]https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.ker
>> nel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fmtd%2Flinux.git%2Fcomm
>> it%2F%3Fh%3Dmtd%2Ffixes%26id%3Dda2ef8124f20b4ce18d1d3d24fc7b88e68
>> 7e10bb&amp;data=02%7C01%7Ckuldeep.singh%40nxp.com%7Cee345bdf9f65
>> 44ac9f4508d79fd863d9%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%
>> 7C637153624041330774&amp;sdata=BTRzWWY2z6nZncyktDDIdJFwYTp41S%2
>> Buh99QaJ60e1M%3D&amp;reserved=0
>>
>>> Thanks
>>> Kuldeep
>>>
>>>>
>>>> Regards
>>>> Vignesh
>>>>
>>>>
>>>
>>
>> --
>> Regards
>> Vignesh

-- 
Regards
Vignesh
