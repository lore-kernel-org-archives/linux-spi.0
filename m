From: Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [RESEND] spi/tegra114: Correct support for cs_change
Date: Mon, 23 Sep 2013 16:24:14 -0600
Message-ID: <CAPnjgZ3GB8q=CMREX6YF_TR-FD6kRTZwWpJTuNQRA2JNmGWRMQ@mail.gmail.com>
References: <1379528245-6283-1-git-send-email-rklein@nvidia.com>
	<52408DC8.3020407@wwwdotorg.org>
	<52409B1E.3030405@nvidia.com>
	<52409D63.3020909@wwwdotorg.org>
	<5240AC3A.9060206@nvidia.com>
	<5240AF20.8030301@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Rhyland Klein <rklein-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
	Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
	Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
	"spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5240AF20.8030301-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

[trying again]

Hi,

On Mon, Sep 23, 2013 at 3:14 PM, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote:
> On 09/23/2013 03:01 PM, Rhyland Klein wrote:
>> On 9/23/2013 3:58 PM, Stephen Warren wrote:
>>> On 09/23/2013 01:48 PM, Rhyland Klein wrote:
>>>> On 9/23/2013 2:51 PM, Stephen Warren wrote:
>>>>> On 09/18/2013 12:17 PM, Rhyland Klein wrote:
>>>>>> The tegra114 driver wasn't currently handling the cs_change functionality.
>>>>>> It is meant to invert normal behavior, and we were only using it to possibly
>>>>>> delay at the end of a transfer.
>>> ...
>>>>>> diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
>>> ...
>>>>>> @@ -717,7 +718,12 @@ static int tegra_spi_start_transfer_one(struct spi_device *spi,
>>>>>>           else if (req_mode == SPI_MODE_3)
>>>>>>                   command1 |= SPI_CONTROL_MODE_3;
>>>>>>
>>>>>> -         tegra_spi_writel(tspi, command1, SPI_COMMAND1);
>>>>>> +         if (tspi->cs_control) {
>>>>>> +                 if (tspi->cs_control != spi)
>>>>>> +                         tegra_spi_writel(tspi, command1, SPI_COMMAND1);
>>>>>
>>>>> Do you really need a separate write call there? The value of command1
>>>>> isn't fully set up there (the CS bits are all set up immediately after),
>>>>> so won't that glitch the CS lines in some cases?
>>>>
>>>> On our hardware (as far as I've seen), the CS line is normally low. We
>>>
>>> I assume you meant "normally *active* low", not "normally low"?
>>
>> I mean that when I look at CS, before a transaction starts, the line is
>> low. Then we do a write like this (default SPI_COMMAND1) you see CS rise
>> and fall very soon after. This is purely how we generate the edge
>> triggers (as far as I can tell on all Tegra hw, though Laxman can
>> correct me if I am wrong).
>
> That sounds broken. Normally, shouldn't CS assert before a transaction,
> stay asserted during a transaction, then deassert after the transaction?
> It shouldn't rise and fall very quickly in between parts of the transaction.
>
>>>> need to generate a falling-edge to trigger the beginning of a SPI
>>>> transaction. Doing this write with the default value of SPI_COMMAND1
>>>> causes a brief rise and fall of CS, giving us our falling-edge.
>>>
>>> That sounds like exactly the glitch I was talking about.
>>>
>>> Assuming CS isn't held constantly asserted (low), isn't CS de-asserted
>>> (rises) at the end of transaction n-1, and re-asserted (falls) at the
>>> start of transaction n? If so, I'm not sure why the setup for
>>> transaction n needs to both de-assert and then re-assert it? It seems
>>> like cs_control should be handled at the end of a transaction, not at
>>> the start of the next one.
>>
>> cs_change has to maintain state over spi_message boundries, not just
>> between spi_transfers within a spi_message.
>>
>> In this specific case, this is a safe guard.
>>
>>>>>> +         if (tspi->cs_control) {
>> This sees that the previous transfer stored its spi_device pointer,
>> meaning it had cs_change set on the last part of the last spi_message
>> (I.E. CS hasn't been deasserted, so the SPI transaction is still on-going).
>>
>>>>>> +                 if (tspi->cs_control != spi)
>> This however finds that the device trying to send a SPI message isn't
>> the same one that was in the middle of its transaction. This is a
>> collision between 2 clients on 1 bus. This simply ends the previous
>> transaction (the ongoing one) in favor of starting a new transaction.
>>
>> Otherwise, this logic allows us to skip the spi of COMMAND1 which would
>> normally be used to create the falling edge to start a new transaction,
>> leaving the previous one open for more transfers.
>
> This sounds like something the SPI core should be managing. If a driver
> is using the SPI bus to communicate with a device in a way that needs CS
> left active while outside a transaction, it shouldn't be possible for
> another driver to come along and communicate with another device before
> the first transaction is all complete. The bus should be locked.
> Allowing anything else could corrupt the protocol that required specific
> CS states outside the transaction.

Perhaps the client driver should use spi_sync_locked() instead if it
wants to avoid this problem? To me this driver code seems reasonable
in the circumstances.

Note: at present the Chrome OS EC driver does not support sharing a
SPI bus with anything else, and neither does the EC.

Regards,
Simon
