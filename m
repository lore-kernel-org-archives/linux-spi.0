From: Esben Haabendal <esben.haabendal@gmail.com>
Subject: Re: [PATCH 03/12] spi: spi-fsl-dspi: Fix per transfer cs_change handling
Date: Wed, 20 Jun 2018 15:40:04 +0200
Message-ID: <87r2l1mv9n.fsf@gmail.com>
References: <20180620073442.20913-1-esben.haabendal@gmail.com>
        <20180620073442.20913-4-esben.haabendal@gmail.com>
        <20180620132755.GF6242@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Cc: linux-spi@vger.kernel.org, Kurt Kanzenbach <kurt@linutronix.de>,
        Angelo Dureghello <angelo@sysam.it>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        Yuan Yao <yao.yuan@nxp.com>, linux-kernel@vger.kernel.org,
        Martin =?utf-8?Q?Hundeb=C3=B8ll?= <martin@geanix.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180620132755.GF6242@sirena.org.uk> (Mark Brown's message of
        "Wed, 20 Jun 2018 14:27:55 +0100")
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Mark Brown <broonie@kernel.org> writes:

> On Wed, Jun 20, 2018 at 09:34:33AM +0200, Esben Haabendal wrote:
>
>> As of 92dc20d83adec565378254c0630e839ff5674e14, transfer->cs_change has
>> been supported for non-last transfers, but not for last transfer.
>
> Please include human readable descriptions of things like commits and
> issues being discussed in e-mail in your mails, this makes them much
> easier for humans to read especially when they have no internet access.
> I do frequently catch up on my mail on flights or while otherwise
> travelling so this is even more pressing for me than just being about
> making things a bit easier to read.

Ok.  I will add the commit title to v2.

/Esben
