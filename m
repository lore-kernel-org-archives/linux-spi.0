From: Pierre-Louis Bossart <pierre-louis.bossart-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [alsa-devel] Fwd: [PATCH 1/1] SPI : spi-pxa2xx : fix spi init
 of WM510205 codec via ACPI (resend)
Date: Fri, 26 Jun 2015 13:46:50 +0200
Message-ID: <558D3BAA.3080700@linux.intel.com>
References: <CAKor6TfKws63jh6f3VzyYpmTffL4-DHWDTdJ6GSgDC08C5W=8w@mail.gmail.com> <20150625073618.GH827@lahna.fi.intel.com> <CAKor6TfxNW6UW6iX_FkRn2yZOHvdRHcsj6pKoKH-UWU51Bqvvg@mail.gmail.com> <20150625145853.GP14071@sirena.org.uk> <20150625154407.GE6321@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org,
	Christian Hartmann <cornogle-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>,
	mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org,
	Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
	dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org
To: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150625154407.GE6321-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 6/25/15 5:44 PM, Charles Keepax wrote:
> On Thu, Jun 25, 2015 at 03:58:53PM +0100, Mark Brown wrote:
>> On Thu, Jun 25, 2015 at 02:18:23PM +0200, Christian Hartmann wrote:
>>
>>>                  Name (_HID, "WM510205")  // _HID: Hardware ID
>>>                  Name (_CID, "WM510205")  // _CID: Compatible ID
>>>                  Name (_DDN, "Wolfson Microelectronics Audio WM5102=
")
>>
>> Separately to the chip select discussion one thing to highlight here=
 is
>> that for some reason the BIOS is listing the device as "WM510205" ra=
ther
>> than "WM5102" - do those extra numbers mean anything and does this m=
ean
>> that WM50120[1-4] and possibly higher numbers are also valid?
>
>  From my brief discussions with the Windows guys here on this
> basically those last two digits are being used to inform the
> Windows driver of use-case setup. So here it will set things up
> for whatever the Window's driver considers to be setup "5".
>
> I think from the Linux side we can safely ignore those last two
> digits. I expect that all systems of the same make and model
> would report the same last two digits but that it might change
> between models if the Windows driver is expected to something
> differently for that model.

Here's the summary of what a valid _HID  should look like. It took me a=
=20
couple of days to gather the rules from different sources, I hope it=20
helps others figure things out.
-Pierre

_HID must be one of these forms:
- "AAA####=94 or EisaID(=93AAA####=94) where A is an uppercase letter a=
nd # is=20
a hex digit. The AAA PNP Vendor ID consists of 3 characters, verified o=
n
http://www.uefi.org/sites/default/files/resources/PNPID_List.pdf

- "ACPI####=94 where # is a hex digit

- "NNNN####=94 where N is an uppercase letter or decimal digit (0-9) an=
d #=20
is a hex digit (ACPI 5.0).
The NNNN Vendor ID can be
--> a PCI ID: 4 hex digits (0-9 and A-F), verified on
https://www.pcisig.com/membership/vid_search/
--> or an ACPI ID: 4 characters, each character being either an=20
uppercase letter (A-Z) or a numeral (0-9), verified on
http://www.uefi.org/sites/default/files/resources/ACPIID_List.pdf




--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
