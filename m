From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH] pxa2xx: replace spi_master with spi_controller
Date: Fri, 18 Jan 2019 23:13:51 +0100
Message-ID: <87won1r4v4.fsf@belgarion.home>
References: <20190116151330.1971861-1-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Mark Brown <broonie@kernel.org>, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Lubomir Rintel <lkundrak@v3.sk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190116151330.1971861-1-lkundrak@v3.sk> (Lubomir Rintel's
        message of "Wed, 16 Jan 2019 16:13:31 +0100")
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Lubomir Rintel <lkundrak@v3.sk> writes:

> It's also a slave controller driver now, calling it "master" is slightly
> misleading.

I think the patch subject's prefix is not correct, should be :
"spi: pxa2xx: replace spi_master with spi_controller".

Apart from that, for the mach-pxa:
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

--
Robert
