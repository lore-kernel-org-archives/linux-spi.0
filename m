From: Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH 3/5] spi: pxa2xx: use an enum for type
Date: Wed, 10 Oct 2018 19:26:56 +0200
Message-ID: <817b05ed7a619e9c46594f395ebc02d7cde9fc24.camel@v3.sk>
References: <20180910115935.163121-1-lkundrak@v3.sk>
         <20180910115935.163121-4-lkundrak@v3.sk> <87d0t64mkk.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Bjorn Helgaas <bhelgaas@google.com>
To: Robert Jarzmik <robert.jarzmik@free.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87d0t64mkk.fsf@belgarion.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, 2018-09-21 at 22:34 +0200, Robert Jarzmik wrote:
> Lubomir Rintel <lkundrak@v3.sk> writes:
> 
> > That seems to be the correct type.
> Okay, but what happens here when adev_id->driver_data is a value out
> of enum
> range ? Does the following assignment make sense ?
> > +		type = (enum pxa_ssp_type)adev_id->driver_data;
> 
> As a side note, could you join for the next throw to the review :
>  - Jarkko Nikula <jarkko.nikula@linux.intel.com>
>  - Mika Westerberg <mika.westerberg@linux.intel.com>

Argh, of course I forgot. My apologies.

Jarkko & Mika, I'm wondering if you could take a look at the [1] thread
and tell me what you think. (I can forward it to you via e-mail too, if
you're not subscribed to lists it has been Cc'd to, if that would be
more convenient).

[1] [PATCH 0/11] spi: pxa2xx: add DT and slave mode support"
    https://lore.kernel.org/lkml/20181010170936.316862-1-lkundrak@v3.sk/T/#t

Thanks
Lubo

> 
> Even if they are Intel, I think they have worked a lot on this driver
> for Intel
> platforms.
> 
> Cheers.
> 
