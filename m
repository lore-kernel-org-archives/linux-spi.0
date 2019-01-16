From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 5/6] spi: ath79: Remove some useless includes
Date: Wed, 16 Jan 2019 12:06:41 -0800
Message-ID: <39a7f5c0177dc72033cb6f43a16d93407db7e182.camel@perches.com>
References: <20190116185549.23295-1-albeu@free.fr>
         <20190116185549.23295-5-albeu@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
To: Alban Bedel <albeu@free.fr>, linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190116185549.23295-5-albeu@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, 2019-01-16 at 19:55 +0100, Alban Bedel wrote:
> Several include are not needed, remove them to keep the list clean.
[]
> diff --git a/drivers/spi/spi-ath79.c b/drivers/spi/spi-ath79.c
[]
> @@ -12,15 +12,12 @@
>   *
>   */
>  
> -#include <linux/kernel.h>

I think it's not a good idea to remove kernel.h
just because module.h indirectly #includes it via
moduleparam.h
