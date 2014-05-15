From: "George Spelvin" <linux@horizon.com>
Subject: Re: [PATCH v2 1/3] lib/crc7: Shift crc7() output left 1 bit
Date: 14 May 2014 22:02:38 -0400
Message-ID: <20140515020238.32013.qmail@ns.horizon.com>
References: <2e076c13-84aa-4da4-a443-7e8fcc462fc9@email.android.com>
Cc: arik@wizery.com, david.gnedt@davizone.at, eliad@wizery.com,
	jan.nikitenko@gmail.com, laurent.pinchart+renesas@ideasonboard.com,
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-wireless@vger.kernel.org,
	linville@tuxdriver.com, luca@coelho.fi, tony@atomide.com
To: hpa@zytor.com, linux@horizon.com, pavel@ucw.cz
Return-path: <linux-mmc-owner@vger.kernel.org>
In-Reply-To: <2e076c13-84aa-4da4-a443-7e8fcc462fc9@email.android.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

H. Peter Anvin wrote:
> Seems to me to make the code easier to read, not harder. That was the
> whole point.

I thought it made it harder by moving the terminating 1 bit out of the
driver proper, where it has a symbolic name.  Thus someone comparing
the driver to the spec has to read another source file to figure out
how the driver gets that bit set.

As it is, the straight-line code in the driver corresponds very simply
with the packet as illustrated in the data sheets.

I agree it's really really minor either way, but so is the saving
we're going for.

Since it's not *clearly* an improvement, I err on the side of not
messing with a driver I can't test.
