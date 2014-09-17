From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH 5/5] m25p80,spi-nor: Share the list of supported chip type
 names again
Date: Wed, 17 Sep 2014 10:23:26 +0200
Message-ID: <CAMuHMdVSYvUh3qVRhw15KmOn0MYocbJVQBr9TkHtebM19c8dJA@mail.gmail.com>
References: <1410714624.3040.38.camel@decadent.org.uk>
	<1410714708.3040.43.camel@decadent.org.uk>
	<CAMuHMdUs+7uidcD6tivnq6+TbD4_piixLVqwuSa0Z1u3sF7EoA@mail.gmail.com>
	<1410793627.3040.61.camel@decadent.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>,
	Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Huang Shijie <shijie8-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Ian Campbell <ijc-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	debian-kernel <debian-kernel-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Ben Hutchings <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1410793627.3040.61.camel-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Ben,

On Mon, Sep 15, 2014 at 5:07 PM, Ben Hutchings <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org> wrote:
>> >
>> > +#define __SPI_NOR_ENUM_TYPES(c_id, str_and_c_id)                         \
>> > +       c_id(at25fs010)         c_id(at25fs040)         c_id(at25df041a)  \
>> > +       c_id(at25df321a)        c_id(at25df641)         c_id(at26f004)    \
>>
>> Can't you just have the IDs in a header file only, and let the header file
>> generate either a struct flash_info or a struct spi_device_id table, using
>> a macro defined by the file that includes it?
>
> How would we match up the rest of the struct flash_info to the name?

Ah, you use the enums to match the names to the rest of the flash_info.
But you can do it in one-shot, can't you?

spi-nor-data.h:

FLASH_ENTRY("at25fs010", 0x1f6601, 0, 32 * 1024,   4, SECT_4K),
FLASH_ENTRY("at25fs040", 0x1f6604, 0, 64 * 1024,   8, SECT_4K),
...

m25p80.c:

#define FLASH_ENTRY(_name, _jedec_id, _ext_id, _sector_size,
_n_sectors, _flags) \
        { .name = _name },

static const struct spi_device_id m25p_ids[] = {
#include "spi-nor-data.h"
};

spi-nor.c:

#define FLASH_ENTRY(_name, _jedec_id, _ext_id, _sector_size,
_n_sectors, _flags) \
        { \
                 .name = _name, \
                .jedec_id = (_jedec_id), \
                .ext_id = (_ext_id), \
                .sector_size = (_sector_size), \
                .n_sectors = (_n_sectors), \
                .page_size = 256, \
                .flags = (_flags), \
        }

static const struct flash_info spi_nor_info[] = {
#include "spi-nor-data.h"
};

Then the whole table data in contained in one place (spi-nor-data.h).
Am I still missing something?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
