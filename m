From: Dirk Brandewie <dirk.brandewie@gmail.com>
Subject: Re: [PATCH 01/11] spi-dw: expose platform data stucture.
Date: Wed, 22 Jun 2011 22:16:11 -0700
Message-ID: <4E02CC1B.2070403@gmail.com>
References: <1308794413-11069-1-git-send-email-dirk.brandewie@gmail.com> <1308794413-11069-2-git-send-email-dirk.brandewie@gmail.com> <BANLkTin9Ouf76VEFRam+eo=H7Gw3Tv6OLA@mail.gmail.com> <4E02BA68.2010108@gmail.com> <127d80e7-0bb6-4961-891e-2ab791ac6368@email.android.com> <4E02C30A.5040106@gmail.com> <8a51d0af-e018-40d4-8aa6-8c42caa5cccf@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net
To: "glikely@secretlab.ca" <grant.likely@secretlab.ca>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8a51d0af-e018-40d4-8aa6-8c42caa5cccf@email.android.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 06/22/2011 10:06 PM, glikely@secretlab.ca wrote:
>
>
> Dirk Brandewie<dirk.brandewie@gmail.com>  wrote:
>
>> On 06/22/2011 09:03 PM, glikely@secretlab.ca wrote:
>>>
>>>
>>> Dirk Brandewie<dirk.brandewie@gmail.com>   wrote:
>>>
>>>> On 06/22/2011 08:47 PM, Grant Likely wrote:
>>>>> On Wed, Jun 22, 2011 at 8:00 PM,<dirk.brandewie@gmail.com>    wrote:
>>>>>> From: Dirk Brandewie<dirk.brandewie@gmail.com>
>>>>>>
>>>>>> Expose the platform data structure for use by client drivers. ATM
>>>>>> there are not any in-tree drivers using the driver (that I can
>>>>>> find). This patch exposes the platform data needed for client
>>>> drivers.
>>>>>
>>>>> ?  Why would client drivers want to muck with this configuration?
>> I
>>>>> can understand the dw_spi driver being able to have per-spi_device
>>>>> configuration, but spi_drivers absolutely should not have
>> visibility
>>>>> into bus-specific details.  Am I misunderstanding something.
>>>>>
>>>>
>>>> Most of these config options don't need to be client configurable
>> IMHO
>>>> but they
>>>> are being used ATM by drivers that aren't upstream and the current
>>>> controller
>>>> driver uses them.  This patch is to give a smooth transition
>>>> (bisectable) to my
>>>> change that reworks the core message and transfer handling code.
>>>>
>>>> This allows me to provide patches to the developers of the out of
>> tree
>>>> drivers
>>>> that should be coming in RSN and exposes the interface they are
>> using
>>>> now.
>>>
>>> My question still stands. Are you expecting spi_driver code to
>> manipulate this data?
>>>
>>>
>>
>> The current drivers behaviour is driven by this data provided by the
>> client.
>> This makes the current client drivers work since some have not picked
>> picked up
>> your change moving dw_spi.h out of include/linux/spi (right answer
>> IMHO) and
>> provides the interface they are using now.
>
> So the situation is that certain out-of-tree spi_drivers are reaching into internal details of a specific spi bus driver?
>If so, then that is wrong and bad, and certainly will not be merged. Especially when there are no in tree users and neither
>does this series add any.

OK

Since the current driver used pxa2xx_spi.c as a template I was following the 
example provided by include/linux/spi/pxa2xx_spi.h.  I have no problem dropping 
this patch until I finish the rest of the rework planned. Was trying to limit 
the amount of heartburn others on the list had with my changes.

--Dirk
>
> g.
>
>>
>> --Dirk
>
