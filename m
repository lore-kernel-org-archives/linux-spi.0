From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH v5 01/12] misc: add driver for sequencer serial port
Date: Tue, 16 Nov 2010 13:35:40 -0700
Message-ID: <AANLkTik76EY8Xh01YP2Tep6k1ETPO+3idmNuk3pVikJG@mail.gmail.com>
References: <1289848334-8695-1-git-send-email-cyril@ti.com>
	<1289848334-8695-2-git-send-email-cyril@ti.com>
	<20101116071047.GE4074@angua.secretlab.ca>
	<4CE2AE3C.4040805@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org"
	<davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>,
	"dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org" <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	"sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	"khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org" <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>,
	"broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org"
	<broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	"rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org" <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	"akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org" <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	"alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org" <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>,
	"lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org" <lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org>
To: cyril-l0cyMroinI0@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4CE2AE3C.4040805-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, Nov 16, 2010 at 9:15 AM, Cyril Chemparathy <cyril-l0cyMroinI0@public.gmane.org> wrote:
> On 11/16/2010 02:10 AM, Grant Likely wrote:
>> On Mon, Nov 15, 2010 at 02:12:03PM -0500, Cyril Chemparathy wrote:
>>> TI's sequencer serial port (TI-SSP) is a jack-of-all-trades type of ser=
ial port
>>> device. =A0It has a built-in programmable execution engine that can be =
programmed
>>> to operate as almost any serial bus (I2C, SPI, EasyScale, and others).
>>>
>>> This patch adds a driver for this controller device. =A0The driver does=
 not
>>> expose a user-land interface. =A0Protocol drivers built on top of this =
layer are
>>> expected to remain in-kernel.
>>>
> [...]
>>> +static inline void ssp_write(struct ti_ssp *ssp, int reg, u32 val)
>>> +{
>>> + =A0 =A0 __raw_writel(val, ssp->regs + reg);
>>> +}
>>
>> I'm pretty sure it was resolved that __raw_ versions should not be
>> used here.
>
> The endian-swap done by writel/readl are incorrect since these devices
> are meant to be accessed native-endian at all times.
>
> See [1] below for Russell King's earlier response on this. =A0In this
> case, I don't think memory-device ordering matters, and therefore the
> __raw_ variants should be ok. =A0Should I just insert barriers into the
> read/write wrappers here?

I'll let Russel make the decision here; but I must admit I'm puzzled.
Are you running an ARMEB machine?  the le32_to_cpu macros should be
no-ops on little endian.  If you do still use the __raw variants, then
at the very least the reason for doing so must be well documented.

Personally, I'd rather see the appropriate macros added to io.h
ioread32be()/iowrite32be() perhaps?  Or am I missing something subtle
about the hardware behaviour?

g.

---------------------------------------------------------------------------=
---
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today
http://p.sf.net/sfu/msIE9-sfdev2dev
