From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH v6 08/12] gpio: add ti-ssp gpio driver
Date: Sun, 21 Nov 2010 14:31:38 -0700
Message-ID: <AANLkTikYu4H8aWOvK+q6g4YgUZxD_80UKBdr=eB__frF@mail.gmail.com>
References: <1290182156-20104-1-git-send-email-cyril@ti.com>
	<1290182156-20104-9-git-send-email-cyril@ti.com>
	<4CE97AE5.3040801@bluewatersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org,
	dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org,
	khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org,
	rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org, alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org,
	Cyril Chemparathy <cyril-l0cyMroinI0@public.gmane.org>, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org
To: Ryan Mallon <ryan-7Wk5F4Od5/oYd5yxfr4S2w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4CE97AE5.3040801-7Wk5F4Od5/oYd5yxfr4S2w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Sun, Nov 21, 2010 at 1:02 PM, Ryan Mallon <ryan-7Wk5F4Od5/oYd5yxfr4S2w@public.gmane.org> wrote:
> On 11/20/2010 04:55 AM, Cyril Chemparathy wrote:
>> TI's SSP controller pins can be directly read and written to behave like=
 a
>> GPIO. =A0This patch adds a GPIO driver that exposes such functionality.
>>
>> Signed-off-by: Cyril Chemparathy <cyril-l0cyMroinI0@public.gmane.org>
>> ---
>
>> +static int __devinit ti_ssp_gpio_probe(struct platform_device *pdev)
>> +{
>> + =A0 =A0 const struct ti_ssp_gpio_data *pdata =3D pdev->dev.platform_da=
ta;
>> + =A0 =A0 struct device *dev =3D &pdev->dev;
>> + =A0 =A0 struct ti_ssp_gpio_chip *gpio;
>> + =A0 =A0 int error;
>> +
>> + =A0 =A0 if (!pdata) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "platform data not found\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 gpio =3D kzalloc(sizeof(*gpio), GFP_KERNEL);
>> + =A0 =A0 if (!gpio) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "cannot allocate driver data\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 gpio->dev =3D dev;
>> + =A0 =A0 gpio->iosel =3D SSP_PIN_SEL(0, SSP_IN) | SSP_PIN_SEL(1, SSP_IN=
) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SSP_PIN_SEL(2, SSP_IN) | SSP_PIN_S=
EL(3, SSP_IN);
>> + =A0 =A0 error =3D ti_ssp_set_iosel(gpio->dev, gpio->iosel);
>> + =A0 =A0 if (error < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "gpio io setup failed (%d)\n", er=
ror);
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto error;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 spin_lock_init(&gpio->lock);
>> + =A0 =A0 platform_set_drvdata(pdev, gpio);
>
> This looks wrong. gpio is of type ti_ssp_gpio_chip, but the ssp core
> functions, ssp_read, etc, use dev_to_ssp:

This sets the child device's private data pointer, not the parents.
dev_to_ssp still correctly returns the parent device private data.

>
> static inline struct ti_ssp *dev_to_ssp(struct device *dev)
> {
> =A0 =A0 =A0 =A0return dev_get_drvdata(dev->parent);
> }
>
> If I understand correctly, the ssp core can only be used to for one
> peripheral at a time.

I believe the ssp has 2 channels; thus up to 2 child devices.

> Currently the code will allow you to install
> several peripherals at once, which will lead to odd behaviour at
> runtime. Maybe a better approach would be to have something like this in
> drivers/mfd/ti-ssp.c:

Only the ssp core itself is allowed to register the peripheral
devices, and so using the parent pointer is perfectly valid.  I think
Cyril's approach is fine.

g.

---------------------------------------------------------------------------=
---
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today
http://p.sf.net/sfu/msIE9-sfdev2dev
