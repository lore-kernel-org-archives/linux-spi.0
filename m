From: Christophe Ricard <christophe.ricard-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 1/3] acpi: Rename acpi_gsi_get_irq_type to
 acpi_get_irq_type and export symbol
Date: Tue, 8 Dec 2015 22:57:19 +0100
Message-ID: <5667523F.60704@gmail.com>
References: <1449527952-8399-1-git-send-email-christophe-h.ricard@st.com>
 <1449527952-8399-2-git-send-email-christophe-h.ricard@st.com>
 <20151208112855.GI1766@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
	gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org,
	broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Christophe Ricard <christophe-h.ricard-qxv4g6HH51o@public.gmane.org>
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151208112855.GI1766-3PARRvDOhMZrdx17CPfAsdBPR1lH4CV8@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mika,

gpio irq type are usually denoted using IRQ_TYPE_xxx.
Lukily acpi_dev_irq_flags would work for  because IORESOURCE_IRQ and 
IRQ_TYPE numbers match.
In include/linux/ioport.h, IORESOURCE_IRQ looks to be more related with 
PnP stuff:
"PnP IRQ specific bits (IORESOURCE_BITS)"

I believe changes done in this patch take benefit of another existing 
function used in acpi gsi context that is doing the
job as expected.

Do you still believe acpi_dev_irq_flags is more appropriate ?

Best Regards
Christophe

On 08/12/2015 12:28, Mika Westerberg wrote:
> On Mon, Dec 07, 2015 at 11:39:10PM +0100, Christophe Ricard wrote:
>> acpi_gsi_get_irq_type could be use out of gsi purpose.
>>
>> Rename and make it available as a utility function.
>>
>> Signed-off-by: Christophe Ricard <christophe-h.ricard-qxv4g6HH51o@public.gmane.org>
> There is already a function acpi_dev_irq_flags() converts ACPI flags to
> Linux resource IRQ flags. Any reason you are not using that?

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
