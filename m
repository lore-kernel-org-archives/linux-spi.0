From: Josh Coombs <josh.coombs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 11/12] ARM: Kirkwood: Use DT to configure SATA device.
Date: Tue, 3 Jul 2012 10:52:17 -0400
Message-ID: <CAMW5Ufa2bsYs9VD2g9hJWKpcQNcZt+WXCA1ohYoHeLk9SambSg@mail.gmail.com>
References: <1341325365-21393-1-git-send-email-andrew@lunn.ch>
	<1341325365-21393-12-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>,
	devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org,
	grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>,
	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1341325365-21393-12-git-send-email-andrew-g2DYL2Zd6BY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, Jul 3, 2012 at 10:22 AM, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org> wrote:
> Convert boards using DT, but the old way of configuring SATA to now
> use properties in there DT file.

Andrew, should I be updating my GoFlex patch set to work with these
new Kirkwood DT abstractions, and if so is there a specific tree you'd
prefer I work against, or should I wait to see if my existing patch
set is approved as is and update with a new patch once these updates
land in an RC?

Josh Coombs
