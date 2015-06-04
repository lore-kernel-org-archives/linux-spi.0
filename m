From: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 04/11] mtd: ofpart: do not fail probe when no partitions exist
Date: Thu, 4 Jun 2015 06:54:00 +0200
Message-ID: <CAOMqctTB2AYOQZUc9o-R4PF1DQ-HY0RfSw5T-T28r5uP2s=qZA@mail.gmail.com>
References: <cover.1433364398.git.hramrach@gmail.com> <36e315552c849a4d22ac0fcff7958f6ffcafb160.1433364398.git.hramrach@gmail.com>
 <201506040058.52882.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
	Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Han Xu <han.xu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>,
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Alison Chaiken <alison_chaiken-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>,
	Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Ben Hutchings <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>,
	Knut Wohlrab <knut.wohlrab-V5te9oGctAVWk0Htik3J/w@public.gmane.org>,
	=?UTF-8?B?QmVhbiBIdW8g6ZyN5paM5paMIChiZWFuaHVvKQ==?=
	<beanhuo-AL4WhLSQfzjQT0dZR+AlfA@public.gmane.org>, "grmoore@altera.c
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201506040058.52882.marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 4 June 2015 at 00:58, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org> wrote:
> On Wednesday, June 03, 2015 at 11:26:40 PM, Michal Suchanek wrote:
>> On Exynos it is necessary to set SPI controller parameters that apply to
>> a SPI slave in a DT subnode of the slave device. The ofpart code returns
>> an error when there are subnodes of the SPI flash but no partitions are
>> found. Change this condition to a warning so that flash without
>> partitions can be accessed on Exynos.
>
> I have to admit the rationale for this patch is not very clear to me, sorry.
> Can you please explain this a bit more ?

This is how the DT entry for SPI slave looks with s3c64xx:
flash: m25p80@0 {
        #address-cells = <1>;
        #size-cells = <1>;
        compatible = "jedec,spi-nor";
        reg = <0>;
        spi-max-frequency = <40000000>;
        linux,max_tx_len = <65536>;
        m25p,fast-read;
        controller-data {
            samsung,spi-feedback-delay = <0>;
        };
    };

this is example of flash partitions:
flash@0 {
        #address-cells = <1>;
        #size-cells = <1>;

        partition@0 {
                label = "u-boot";
                reg = <0x0000000 0x100000>;
                read-only;
        };

        uimage@100000 {
                reg = <0x0100000 0x200000>;
        };
};

The parser ignores any flash without subnodes and returns 0 (no
partititon). When there is a subnode it assumes the flash is
partitioned and tries to parse the subnodes as partitions. When there
are subnodes and none parses as partition an error is returned. As
shown above it is valid to have subnodes on unpartitioned flash.

When an error is returned from a partition parser the mtdpart code
passes on this error to the flash probe function and the proble of the
flash fails.

Thanks

Michal
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
