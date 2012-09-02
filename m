From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v6 1/3] spi/pl022: Add chip select handling via GPIO
Date: Sun, 2 Sep 2012 09:18:29 +0200
Message-ID: <CACRpkdY3atmx4N-Zq2imrgPoukueYiexzndD7bVyQTgV02Vpuw@mail.gmail.com>
References: <1345643359-16584-1-git-send-email-stigge@antcom.de>
	<CAPub14-Oot_wJsRTv2AGu3SAAf40+3_wK43=0Swxj+5XjPaDew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Roland Stigge <stigge-uj/7R2tJ6VmzQB+pC5nmwQ@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	gabriel.fernandez-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org,
	broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org,
	rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
	sachin.verma-lpHj6iFQ3dU@public.gmane.org, aletes.xgr-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
To: shiraz hashim <shiraz.linux.kernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <CAPub14-Oot_wJsRTv2AGu3SAAf40+3_wK43=0Swxj+5XjPaDew-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Sat, Sep 1, 2012 at 1:14 PM, shiraz hashim
<shiraz.linux.kernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Hi Roland,
>
> On Wed, Aug 22, 2012 at 7:19 PM, Roland Stigge <stigge-uj/7R2tJ6VmzQB+pC5nmwQ@public.gmane.org> wrote:
>> @@ -2016,6 +2030,8 @@ pl022_probe(struct amba_device *adev, co
>>         pl022->master_info = platform_info;
>>         pl022->adev = adev;
>>         pl022->vendor = id->data;
>> +       /* Point chipselects to allocated memory beyond the main struct */
>> +       pl022->chipselects = (int *) pl022 + sizeof(struct pl022);
>
> This is going beyond memory allocated for chipselects
> as it adds 4 * sizeof(struct pl022) bytes to pl022.

Yes that is why the allocation looks like this:

+       master = spi_alloc_master(dev, sizeof(struct pl022) + sizeof(int) *
+                                 platform_info->num_chipselect);

> pl022->chipselects = (int *) &pl022[1];
> can be musch safer.

I see absolutely no sematic difference between these two
methods to reach the first position beyond the first struct.

If we're gonna be debating this it's a safe sign that this is
not a good design pattern at all, so then it is better to simply
devm_kzalloc(sizeof(int) * platform_info->num_chipselect);
separately.

(But I'm happy with the patch as it is. And the other way
too, since I'm not very picky.)

Yours,
Linus Walleij

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
