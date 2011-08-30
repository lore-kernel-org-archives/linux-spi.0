From: Ben Gamari <bgamari.foss@gmail.com>
Subject: GPIO chip select support
Date: Tue, 30 Aug 2011 09:50:53 -0400
Message-ID: <1314712254-27199-1-git-send-email-bgamari.foss@gmail.com>
References: <CA+dZkakw9COsETWZkvMzp2v-ymfQdDEqp3jJuhWbrRTTTjpbGQ@mail.gmail.com>
Cc: beagleboard@googlegroups.com, linux-omap@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net
To: Raju Sana <venkat.rajuece@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <CA+dZkakw9COsETWZkvMzp2v-ymfQdDEqp3jJuhWbrRTTTjpbGQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


Thanks for the poke. I've been meaning to send this set out again anyways.

This is the patch I am currently using (on top of v3.0). Conceptually it's
quite similar to the first patches I sent out but some implementation details
were slightly reworked to account for the generalization of the McSPI driver to
other silicon.

I would say that the patch is close to mergable save the fact that there is
currently no clean way to set up GPIO CS pins from a board file. I'll send the
horrible hack I currently use shortly. If anyone has any ideas on how this
might be done cleanly please let me know. It's sad that the mere lack of a
configuration interface is the reason this isn't upstream.

Cheers,

- Ben

