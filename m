From: Sebastian Hesselbarth <sebastian.hesselbarth-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Re: [PATCH v2 01/12] ARM: Orion: DT support for IRQ and GPIO Controllers
Date: Thu, 05 Jul 2012 14:09:59 +0200
Message-ID: <4FF58417.8050001@googlemail.com>
References: <1341325365-21393-1-git-send-email-andrew@lunn.ch> <1341325365-21393-2-git-send-email-andrew@lunn.ch> <20120705110251.596331e0@skate> <20120705094824.GO17534@lunn.ch> <87sjd6ikkj.fsf@lebrac.rtp-net.org> <20120705122050.2fbc2fe3@skate> <87liiyijb8.fsf@lebrac.rtp-net.org> <20120705134231.3e1801e5@skate> <20120705114815.GT17534@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Arnaud Patard <arnaud.patard-dQbF7i+pzddAfugRpC6u6w@public.gmane.org>,
	Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>,
	Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>,
	devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org,
	grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>,
	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Lior Amsalem <alior-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>,
	Maen Suleiman <maen-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120705114815.GT17534-g2DYL2Zd6BY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 07/05/2012 01:48 PM, Andrew Lunn wrote:
 >> Yes. I am not sure yet how to describe those in the DT, or even if it
 >> is actually useful to describe them. Wouldn't it be simpler to just
 >> leave to the user of the GPIO to use a GPIO that's appropriate for its
 >> usage, i.e not use a GPO when input is needed?
 >
 > We assume the hardware designer has got the basic hardware right. Its
 > not going to work otherwise.
 >
 > What we are trying to detect is a DT author making a typo, assigning a
 > gpio-key to a GPO pin, for example. The current MPP scheme will detect
 > this sort of error and issue a warning to the kernel logs.

The output-only/non-interrupt gpios could be marked as such in DT.
The common code should not install irqs if marked by e.g.
"marvell,gpio-no-irq". The gpio driver already fails to set input
direction on output-only pins. This could be marked by e.g.
"marvell,gpio-output-only" in DT.

Sebastian
