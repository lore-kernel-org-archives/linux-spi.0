From: "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/2] gpio: Add driver for SPI serializers
Date: Mon, 14 Dec 2015 10:47:22 -0600
Message-ID: <566EF29A.7090704@ti.com>
References: <1449863184-29668-1-git-send-email-afd@ti.com>
 <1449863184-29668-3-git-send-email-afd@ti.com>
 <CACRpkda0zAg_vAWd6nZLpWqZo4u5kLbBCCJ4WzO-fP08=CBQTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	"linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CACRpkda0zAg_vAWd6nZLpWqZo4u5kLbBCCJ4WzO-fP08=CBQTQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 12/11/2015 04:09 PM, Linus Walleij wrote:
> On Fri, Dec 11, 2015 at 8:46 PM, Andrew F. Davis <afd-l0cyMroinI0@public.gmane.org> wrote:
>
>> Add generic parallel-in/serial-out shift register GPIO driver.
>>
>> This includes SPI compatible devices like SN74165 serial-out shift
>> registers and the SN65HVS88x series of industrial serializers that can
>> be read over the SPI bus and used for GPI (General Purpose Input).
>>
>> Signed-off-by: Andrew F. Davis <afd-l0cyMroinI0@public.gmane.org>
> (...)
>> +#include <linux/delay.h>
>> +#include <linux/gpio.h>
>
> Use #include <linux/gpio/driver.h> instead.
>

ACK

>> +#include <linux/module.h>
>> +#include <linux/mutex.h>
>> +#include <linux/spi/spi.h>
>> +
>> +#define DEFAULT_NGPIO 8
>> +
>> +struct pisosr_gpio {
>> +       struct gpio_chip chip;
>> +       struct spi_device *spi;
>> +       u8 *buffer;
>> +       size_t buffer_size;
>> +       struct gpio_desc *load_gpio;
>> +       struct mutex lock;
>> +};
>
> Add kerneldoc to this struct.
>

Will do.

>> +static inline struct pisosr_gpio *to_pisosr_gpio(struct gpio_chip *chip)
>> +{
>> +       return container_of(chip, struct pisosr_gpio, chip);
>> +}
>
> We are doing away with this, but I can fix up the driver by a separate
> patch later of we merge it.
>

That will work, thanks.

>> +static int pisosr_gpio_refresh(struct pisosr_gpio *gpio)
>> +{
>> +       int ret;
>> +
>> +       mutex_lock(&gpio->lock);
>> +
>> +       if (gpio->load_gpio) {
>> +               gpiod_set_value(gpio->load_gpio, 1);
>> +               udelay(1); /* registers load time (~10ns) */
>> +               gpiod_set_value(gpio->load_gpio, 0);
>> +               udelay(1); /* registers recovery time (~5ns) */
>
>
> So aren't these load/recovery times dependent on the device?
> I think these should come from the compatible string.
>

Yes, but they are all under 20ns or so, I just put the smallest
reasonable delay to keep a fast host from going under this limit.
(although I doubt any could)

>> +static int pisosr_gpio_get_direction(struct gpio_chip *chip,
>> +                                    unsigned offset)
>> +{
>> +       return GPIOF_DIR_IN;
>> +}
>
> Just return 1, GPIOF_DIR_IN is for the external API.
>

ACK

>> +static int pisosr_gpio_get(struct gpio_chip *chip, unsigned offset)
>> +{
>> +       struct pisosr_gpio *gpio = to_pisosr_gpio(chip);
>> +
>> +       /* Refresh may not always be needed */
>> +       pisosr_gpio_refresh(gpio);
>> +
>> +       return (gpio->buffer[offset / 8] >> (offset % 8)) & 0x1;
>> +}
>
> This looks like a good reason to implement .get_multiple() in the
> same way that we have .set_multiple(), so you agree?
>
> But it's not like I'm requiring you to engineer all that. Just an
> academic reflection of the fact.
>

I was disappointed when I saw only set_multiple, so this would
be something nice to have, I'll look into it.

>> +static int pisosr_gpio_probe(struct spi_device *spi)
>> +{
>> +       struct pisosr_gpio *gpio;
>> +       struct device_node *np = spi->dev.of_node;
>> +       int ret;
>
>
> To match and get a pointer to a compatible-string-specific data variant,
> look at the example in drivers/mfd/tc3589x.c
>

ACK

>> +       gpio = devm_kzalloc(&spi->dev, sizeof(*gpio), GFP_KERNEL);
>> +       if (!gpio)
>> +               return -ENOMEM;
>> +
>> +       spi_set_drvdata(spi, gpio);
>> +
>> +       gpio->chip = template_chip;
>> +       gpio->chip.parent = &spi->dev;
>> +       of_property_read_u16(np, "ngpios", &gpio->chip.ngpio);
>
> As I wrote elsewhere, should come from the variant data, based on the
> compatible string. ngpios is in case you're not using all of them and
> need to restrict the number of used GPIOs. Usually this only applies to
> on-SoC GPIOs that are unrouted.
>

(See my reply to your previous comment on this)

>> +       gpio->spi = spi;
>> +
>> +       gpio->buffer_size = DIV_ROUND_UP(gpio->chip.ngpio, 8);
>> +       gpio->buffer = devm_kzalloc(&spi->dev, gpio->buffer_size, GFP_KERNEL);
>> +       if (!gpio->buffer)
>> +               return -ENOMEM;
>> +
>> +       gpio->load_gpio = devm_gpiod_get(&spi->dev, "load", GPIOD_OUT_LOW);
>> +       if (IS_ERR(gpio->load_gpio)) {
>> +               ret = PTR_ERR(gpio->load_gpio);
>> +               if (ret != -ENOENT && ret != -ENOSYS) {
>> +                       if (ret != -EPROBE_DEFER)
>> +                               dev_err(&spi->dev, "Unable to allocate reset gpio\n");
>
> Reset gpio? Really? Load GPIO?
>

Ops, copy/paste error I think.

Thanks,
Andrew

> Apart from that it looks good.
>
> Yours,
> Linus Walleij
>
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
