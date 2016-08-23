From: Christophe Leroy <christophe.leroy-GgN8y9CXRhA@public.gmane.org>
Subject: How to handle SPI components requiring heading/leading clock cycles
 with CS off
Date: Tue, 23 Aug 2016 18:10:48 +0200
Message-ID: <79679118-c092-1f9c-1972-0bb81bc59411@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Some components requires some clock cycles with chipselect off before 
or/and after the data transfer done with CS on.

Typically IDT801034 QUAD PCM CODEC datasheet states "Note *: CCLK should 
have one cycle before CS goes low, and two cycles after CS goes high".

The only way I see to achieve that is to transfer a 4 bits word with CS 
off before and after the data.
I've not found any way to do so in the current SPI subsystem 
implementation, is there any ?
If not, what would be the best approach to implement that ?

Cheers,
Christophe
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
