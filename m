From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2 2/2] spi: Force CS to be in inactive state after
 off-mode transition
Date: Wed, 10 Nov 2010 10:07:41 -0700
Message-ID: <AANLkTinHnfvi8EHQx6jEmsse5R1w9n5FoFyvgd6m8Khy@mail.gmail.com>
References: <4CDA74DB.1060102@free-electrons.com> <20101110155718.GA2266@angua.secretlab.ca>
 <4CDACB44.4060803@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: spi-devel-general <spi-devel-general@lists.sourceforge.net>,
	linux-omap <linux-omap@vger.kernel.org>,
	David Brownell <dbrownell@users.sourceforge.net>,
	Kevin Hilman <khilman@deeprootsystems.com>
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <4CDACB44.4060803@free-electrons.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Nov 10, 2010 at 9:41 AM, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:
> On 11/10/2010 04:57 PM, Grant Likely wrote:
>>
>> On Wed, Nov 10, 2010 at 11:32:59AM +0100, Gregory CLEMENT wrote:
>>>
>>> When SPI wake up from OFF mode, CS is in the wrong state: force it
>>> to the inactive state.
>>>
>>> During the system life, I monitored the CS behavior using a
>>> oscilloscope. I also activated debug in omap2_mcspi, so I saw when
>>> driver disable the clocks and restore context when device is not
>>> used.
>>> Each time the CS was in the correct state.
>>> It was only when system was put suspend to ram with off-mode
>>> activated that on resume the CS was in wrong state( ie activated).
>>
>> Sounds like a bug in the suspend/resume path of the spi_master, not
>> the spi_device. =A0Trying to work around it via the spi_device resum=
e
>> path is the wrong approach.
>>
>
> OK it was not clear to me that spi_resume() and spi_suspend() were sp=
ecifics
> to devices as these functions belong to a bus structure.
>
> So you suggest to use the suspend/resume functions of the platform_dr=
iver
> structure of omap2_mcspi_driver, right?

correct.

g.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
