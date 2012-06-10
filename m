From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/9] SPI: Refactor spi-orion to use SPI framework queue.
Date: Sun, 10 Jun 2012 18:30:10 +0200
Message-ID: <CACRpkdY+egHAMxwLVOfRPYykeB3=nS=hVmdMDK0Q_6U9PZYbZQ@mail.gmail.com>
References: <1339324322-29388-3-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, machael-QKn5cuLxLXY@public.gmane.org
To: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1339324322-29388-3-git-send-email-andrew-g2DYL2Zd6BY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Sun, Jun 10, 2012 at 12:31 PM, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org> wrote:

> Replace the deprecated master->transfer with transfer_one_message()
> and allow the SPI subsystem handle all the queuing of messages.
>
> Signed-off-by: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
> Acked-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Looks good to me:
Acked-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Yours,
Linus Walleij
