From: Andy Green <andy@openmoko.com>
Subject: Re: [PATCH 0/2] spi: Add support for non-blocking synchronous transfers
Date: Sun, 01 Mar 2009 07:48:38 +0000
Message-ID: <49AA3DD6.4040807@openmoko.com>
References: <20090228081036.31964.80618.stgit@fedora.yogi> <200902281233.50612.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Balaji Rao <balajirrao@openmoko.org>, linux-kernel@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net
To: David Brownell <david-b@pacbell.net>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754149AbZCAHtX@vger.kernel.org>
In-Reply-To: <200902281233.50612.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Somebody in the thread at some point said:

| Note that $SUBJECT concept is nonsense.
| Synchronous calls are by definition blocking ones...

What's meant here is that it won't sleep you and make you wait for an
asynchronous completion.  So the call itself will perform the bitbang
action before returning.

| On Saturday 28 February 2009, Balaji Rao wrote:
|> During the course of development of an accelerometer driver, we saw the
|> necessity to execute spi transfers synchronously within an interrupt
handler.
|
| This sounds like a bad design.  How can you know that no other
| transfers are going on ... or are queued in front of the transfer
| you're requesting?
|
| You'd need to wait for all the other transfers to work their
| way through the transfer queue.  There are *much* better things
| to do in interrupt handlers.

In our case, the sync and async SPI things are mutually exclusive, you
either talk to your thing with interrupt-lockout protected sync
transfers entirely or use the existing API.  It can be enforced if
that's the concern.

I think it's a little fast to call down the airstrike of "bad design" on
being able to use bitbang SPI inside an ISR.  Clearly, adding this
ability does not replace the existing system and exists parallel but
compatibly with it; but the existing system cannot provide the same
capability as it stands.  With two lis302dl motion sensors in GTA02,
they can spam up to 800 interrupts a second that need servicing each
with a 7-byte bitbang read.  The existing SPI setup in Linux does not
provide a way to deal with that in a CPU-friendly and low latency way
(there's no FIFO in these devices either).

|> When using a workqueue instead, we observed a huge number of overruns
|> with very high cpu utlization, which is unacceptable.
|
| Sure, but at least part of that seems to be caused by some
| broken design assumptions.
|
| Why are you even trying to touch SPI devices from hardirq
| context?  That's never going to be OK; "can't-sleep" contexts
| don't mix with "must-sleep" calls.

With the "sync" API addition it is OK, given the mutually exclusive
aspect of it.

|> This series adds a new interface for this and modifies no existing ones.
|
| NAK on these two patches.

I hope this maybe gives some extra context about why we use this system,
and why it can be an interesting option for others in the same situation.

- -Andy
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkmqPdYACgkQOjLpvpq7dMop/ACfUGHL+BilbzlN4E7rACmlC48N
uv0AnjqgzshtVeYdIVz/14OGq4krCn7+
=Qveo
-----END PGP SIGNATURE-----
