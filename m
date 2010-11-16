From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH v5 04/12] spi: add ti-ssp spi master driver
Date: Tue, 16 Nov 2010 00:47:04 -0700
Message-ID: <AANLkTi=utWumLKo9QVWXpkC8WxpgaNJJs+dj=pa2eq-q@mail.gmail.com>
References: <1289848334-8695-1-git-send-email-cyril@ti.com>
	<1289848334-8695-5-git-send-email-cyril@ti.com>
	<20101116072225.GF4074@angua.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org,
	dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org,
	khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org,
	rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org, alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org
To: Cyril Chemparathy <cyril-l0cyMroinI0@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20101116072225.GF4074-MrY2KI0G/OVr83L8+7iqerDks+cytr/Z@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, Nov 16, 2010 at 12:22 AM, Grant Likely
<grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wrote:
> On Mon, Nov 15, 2010 at 02:12:06PM -0500, Cyril Chemparathy wrote:
>> This patch adds an SPI master implementation that operates on top of an
>> underlying TI-SSP port.
>>
>> Signed-off-by: Cyril Chemparathy <cyril-l0cyMroinI0@public.gmane.org>
> [...]
>> +static int __init ti_ssp_spi_init(void)
>> +{
>> + =A0 =A0 return platform_driver_register(&ti_ssp_spi_driver);
>> +}
>> +subsys_initcall(ti_ssp_spi_init);
>
> After discussions about device init dependencies at plumbers, and
> since this is the first SPI device driver I've reviewed since that
> dicussion, this driver gets to be the first to implement the proposed
> policy. =A0:-)
>
> Change this to module_initcall(). =A0Many spi and i2c drivers use
> module or subsys_initcall to try and influence driver probe order so
> that certain regulator chips get registered before the devices that
> try to use them. =A0This approach is insane.
>
> Instead, it is now incumbent on the board support code to ensure that
> any device that depends on another device (including i2c or spi
> regulators) will defer registration until the prerequisite devices are
> bound to drivers.
>
> I don't *think* this change will affect anything in this particular
> patch series, but if it does then let me know and I'll help you work out
> how to fix it using a bus notifier.

Oh, wait, spoke too soon.  You do add a regulator in this series, so
this change will require a fixup.  The solution is to register an
bus_notifier to the spi bus type before you start registering devices.
It also requires deferring the musb_hdrc.1 and tps6116x registrations
until the bus_notifier callback gets called with an indication that
the regulator is bound.  It will look something like this:

static int tnetv107x_spi_notifier_call(struct notifier_block *nb,
				unsigned long event, void *__dev)
{
	struct device *dev =3D __dev;

	if ((event =3D=3D BUS_NOTIFY_BOUND_DRIVER) && (dev =3D=3D (the-regulator))=
) {
		register-the-remaining-devices();
		return NOTIFY_STOP;
	};
	return NOTIFY_DONE;
}

static struct notifier_block tnetv107x_spi_nb =3D {
	.notifier_call =3D tnetv107x_spi_notifier_call,
};

and then in the device registration code, before registering the
regulator:

	bus_register_notifier(&spi_bus_type, &tnetv107x_spi_nb);

Let me know if you have any trouble.

g.

---------------------------------------------------------------------------=
---
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today
http://p.sf.net/sfu/msIE9-sfdev2dev
