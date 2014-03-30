From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RFT] spi: mpc512x-psc: Refactor to use core message
 parsing
Date: Sun, 30 Mar 2014 00:30:14 +0000
Message-ID: <20140330003014.GK21628@sirena.org.uk>
References: <1395932757.17331.1.camel@phoenix>
 <20140329150910.GC2775@book.gsilab.sittig.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yiup30KVCQiHUZFC"
Cc: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>, Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gerhard Sittig <gsi-ynQEQJNshbs@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140329150910.GC2775-kDjWylLy9wD0K7fsECOQyeGNnDKD8DIp@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--yiup30KVCQiHUZFC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 29, 2014 at 04:09:10PM +0100, Gerhard Sittig wrote:

> The core implements the loop over the transfers of a message
> (spi_transfer_one_message() routine).  The logic is
> - unconditionally assert CS at the start of a message
> - invert(?) CS between transfers if the transfer's cs_change
>   property is set
> - deassert CS at the end of the message _if_ transmission was
>   successful _and_ the caller did not ask to keep CS asserted
>   (when the last transfer's cs_change is set)
> Is my interpretation of the implementation correct?  Then I'd
> expect "undocumented features" in the current implementation.

That's what it's intended to do, yes (and what a bunch of drivers were
doing).

> Does it mean that with cs_change set, subsequent transfers will
> run with CS deasserted?  I thought this property would "pulse"
> the CS, i.e. release and re-assert the signal.  The spi.h kernel
> doc suggests so: "(i) If the transfer isn't the last one in the
> message, this flag is used to make the chipselect briefly go
> inactive in the middle of the message."  An approach to adjust
> the core's implementation might be to move the set_cs(true) into
> the transfer loop, and to set_cs(false) between transfers if
> cs_change is set.  Or do the set_cs(false) set_cs(true) sequence
> in the if() arm depending on how the cost might be perceived.

Right, that's what the documentation says and what the bitbang driver
does so we should probably update the code to reflect that.

> And I was not aware of the effect on the message's end, that one
> could leave CS asserted.  The spi.h comment reads "(ii) When the
> transfer is the last one in the message, the chip may stay
> selected until the next transfer.", which fits the
> implementation.  Then it continues "... this is just a
> performance hint; starting a message to another device deselects
> this one.", which might assume a specific hardware implementation
> and need not apply to all setups in general.  I assume that the
> documentation is more permissive or suggests more than the
> subsystem can enforce.

Well, the thing is that for hardware that can't control /CS from
software so anything using it between transfers can't rely on it
happening at all.  Within a transfer you can always paper this over
since there's full visibility of what's going to happen but that's
not possible over transfers.

> And I would like to ask whether determining how CS needs to be
> set at the end of a transfer can be done before the transfer_one
> callback gets invoked.  In the specific MPC512x PSC case, the
> appropriate control is done _during_ transmission.  The injection
> of the MPC512x_PSC_FIFO_EOF txcmd code before feeding more data
> into the TX FIFO will make CS go inactive as the data is drained
> (gets sent over the wire).  So the set_cs() after the transfer's
> completion may be late, won't work and/or will disturb other
> communication in the case of PSC internal SS lines.  Other
> hardware may have similar constraints.  Those who need not handle
> CS during transmission already can ignore the information during
> transfer_one(), and use the regular set_cs() invocation.

It could be I guess, though to be honest I've never been convinced that
supporting set_cs on the final transfer is a sane idea in the first
place - my guess is that it's actually going to cost more on average to
implement it (what with remembering to deassert if another device is
selected and so on) than just unconditionally disabling /CS.

> Is it appropriate for the SPI subsystem to modify the passed in
> transfer descriptions?  In that case the transfer's cs_change

It does already.

> I might have prepared and sent patches, but wanted to verify that
> the issues are present, and how best to address them.  Feel free
> to tell me if this discussion should have its own thread, to not
> end up in the review comments of a patch (although it's RFT).

Another thread would've been helpful - I was reading it thinking it was
going to explain the poor performance!

--yiup30KVCQiHUZFC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTN2WMAAoJELSic+t+oim9atsP+gIJqH/pLQbZvARzFjEY3KEt
bAJBVI5sWFdz5iOuYBcGZKzXwd2rWepUHEMhb92GW/mqkxUvIaAHsaQY3unZmOHF
xIHhGgYvqaHuhEp8hYy8rlJ40FuttnAQntUW27y6870fjylkMcDc2hdmtBtYWFor
lMJRyV+R2kdsg7G35wD/+AklIBHYN5h0gWS198u+Ct+qaiZdsjlpUcPegaAYlXa2
o9sMQF+6Ax+QQHRVXZB/HOIEiJzFjiktOYjuzTp+vLxYW9/47/Mg7W4/sKCZE8+8
u5aUiawgQNEaG56V5L+XMIu30GtgGy4suUHq2PK5jYBLxhtLrdwuacKOPNQ2840U
2wMBe5J3QkiXILyWGysogFdKZvidkJMDwkJvq4NxkXYi19BoRKBiwhOzvyQKj35U
RtoDOZSUzBhj29U52UUCy3S81bZHNdV5IAcnilXUUEVWA2k6dPra1HvaRzRFFtd0
mBYGdLnsZCBfAS9z8IMjtoDt5KfwhJY55hKgS1vtc2ONyKaYJk3IeCxozf05dM6L
pi23ZZgqks0I6+MnusQYA47zkVTGVM81wbzyyEIkV/AkyTClbIYYJSSk/HR2LR1X
wZFuDXIcruWrXVq5TRK1IYr51REj62yoZ1vrpt+nwQuwkPaW1Wv7BZ/WRQBmSn9W
u97S3I1+q55LM71ImH2A
=uUXU
-----END PGP SIGNATURE-----

--yiup30KVCQiHUZFC--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
