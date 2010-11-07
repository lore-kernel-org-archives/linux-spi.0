From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] input: spi: Driver for SPI data stream driven vibrator
Date: Sun, 7 Nov 2010 23:51:57 +0000
Message-ID: <20101107235157.728ea5b6@lxorguk.ukuu.org.uk>
References: <1288013463-21722-1-git-send-email-ilkka.koskinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com,
	linux-kernel@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net
To: Ilkka Koskinen <ilkka.koskinen@nokia.com>
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <1288013463-21722-1-git-send-email-ilkka.koskinen@nokia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


> +	datalen = p->custom_len * sizeof(p->custom_data[0]);

signed

> +	if (datalen > MAX_EFFECT_SIZE) {

unsigned

> +	memcpy(einfo->buf, p->custom_data, datalen);

ungood


