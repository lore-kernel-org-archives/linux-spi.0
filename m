From: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Subject: Re: [PATCH v2 01/12] ARM: Orion: DT support for IRQ and GPIO
 Controllers
Date: Thu, 5 Jul 2012 12:25:27 +0200
Message-ID: <20120705102527.GQ17534@lunn.ch>
References: <1341325365-21393-1-git-send-email-andrew@lunn.ch>
 <1341325365-21393-2-git-send-email-andrew@lunn.ch>
 <20120705110251.596331e0@skate>
 <20120705094824.GO17534@lunn.ch>
 <20120705121029.782b5346@skate>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>,
	devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org,
	grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>,
	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Lior Amsalem <alior-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>,
	Maen Suleiman <maen-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>,
	Arnaud Patard <arnaud.patard-dQbF7i+pzddAfugRpC6u6w@public.gmane.org>
To: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120705121029.782b5346@skate>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

> I've looked at the datasheet for the 88F6281, and the GPIO registers
> look fairly similar with Armada 370/XP, except that:
> 
>  * On 88F6281, there are two GPIO banks, while on Armada 370/XP it's a
>    continuous range of registers that control the GPIOs. But it can be
>    assimilated as one bank handling more than 32 GPIOs. So shouldn't be
>    a big problem to handle.

The number of banks varies. Orion5x has one, Dove has three, etc.

> 
>  * The Armada 370/XP have additional set/clear registers that allow to
>    modify the GPIO states without having to do a read/mask/write
>    sequence, which is nicer on SMP. I guess we can handle that as a
>    variant inside the driver without too much problem.
> 
> Marvell has given me a 88F6282 eval board, so I guess they are fine
> with me spending some time ensuring that the new code works properly on
> the previous platforms, especially in this case where the amount of
> work does not seem to be enormous to keep the compatibility.

That is good to hear.

Thanks
	Andrew
