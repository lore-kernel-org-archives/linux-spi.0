From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH 3/5] spi: pxa2xx: use an enum for type
Date: Fri, 21 Sep 2018 22:34:03 +0200
Message-ID: <87d0t64mkk.fsf@belgarion.home>
References: <20180910115935.163121-1-lkundrak@v3.sk>
        <20180910115935.163121-4-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: text/plain
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Bjorn Helgaas <bhelgaas@google.com>
To: Lubomir Rintel <lkundrak@v3.sk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180910115935.163121-4-lkundrak@v3.sk> (Lubomir Rintel's
        message of "Mon, 10 Sep 2018 13:59:33 +0200")
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Lubomir Rintel <lkundrak@v3.sk> writes:

> That seems to be the correct type.
Okay, but what happens here when adev_id->driver_data is a value out of enum
range ? Does the following assignment make sense ?
> +		type = (enum pxa_ssp_type)adev_id->driver_data;

As a side note, could you join for the next throw to the review :
 - Jarkko Nikula <jarkko.nikula@linux.intel.com>
 - Mika Westerberg <mika.westerberg@linux.intel.com>

Even if they are Intel, I think they have worked a lot on this driver for Intel
platforms.

Cheers.

-- 
Robert
