From: Gerhard Sittig <gsi-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH RFT] spi: mpc512x-psc: Refactor to use core message
 parsing
Date: Sat, 29 Mar 2014 16:09:10 +0100
Message-ID: <20140329150910.GC2775@book.gsilab.sittig.org>
References: <1395932757.17331.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1395932757.17331.1.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

[ in short: I'm confused about chip select semantics :)
  the core implementation may deviate from the documented
  API, the desired CS state for the end of the transfer
  might need to get determined before running the transfer
  already if transmission logic will influence it ]

On Thu, 2014-03-27 at 23:05 +0800, Axel Lin wrote:
> 
> Refactor to use default implementation of transfer_one_message() which provides
> standard handling of delays and chip select management.

When comparing the MPC512x SPI controller's logic to the core
implementation, I noticed a few more differences.

The core implements the loop over the transfers of a message
(spi_transfer_one_message() routine).  The logic is
- unconditionally assert CS at the start of a message
- invert(?) CS between transfers if the transfer's cs_change
  property is set
- deassert CS at the end of the message _if_ transmission was
  successful _and_ the caller did not ask to keep CS asserted
  (when the last transfer's cs_change is set)
Is my interpretation of the implementation correct?  Then I'd
expect "undocumented features" in the current implementation.

Does it mean that with cs_change set, subsequent transfers will
run with CS deasserted?  I thought this property would "pulse"
the CS, i.e. release and re-assert the signal.  The spi.h kernel
doc suggests so: "(i) If the transfer isn't the last one in the
message, this flag is used to make the chipselect briefly go
inactive in the middle of the message."  An approach to adjust
the core's implementation might be to move the set_cs(true) into
the transfer loop, and to set_cs(false) between transfers if
cs_change is set.  Or do the set_cs(false) set_cs(true) sequence
in the if() arm depending on how the cost might be perceived.

And I was not aware of the effect on the message's end, that one
could leave CS asserted.  The spi.h comment reads "(ii) When the
transfer is the last one in the message, the chip may stay
selected until the next transfer.", which fits the
implementation.  Then it continues "... this is just a
performance hint; starting a message to another device deselects
this one.", which might assume a specific hardware implementation
and need not apply to all setups in general.  I assume that the
documentation is more permissive or suggests more than the
subsystem can enforce.

And I would like to ask whether determining how CS needs to be
set at the end of a transfer can be done before the transfer_one
callback gets invoked.  In the specific MPC512x PSC case, the
appropriate control is done _during_ transmission.  The injection
of the MPC512x_PSC_FIFO_EOF txcmd code before feeding more data
into the TX FIFO will make CS go inactive as the data is drained
(gets sent over the wire).  So the set_cs() after the transfer's
completion may be late, won't work and/or will disturb other
communication in the case of PSC internal SS lines.  Other
hardware may have similar constraints.  Those who need not handle
CS during transmission already can ignore the information during
transfer_one(), and use the regular set_cs() invocation.

Is it appropriate for the SPI subsystem to modify the passed in
transfer descriptions?  In that case the transfer's cs_change
might get adjusted before calling transfer_one().  If that's not
possible, the API might need to get extended if the information
cannot get passed in other ways.  I'd like to avoid touching
existing core routine users.

I might have prepared and sent patches, but wanted to verify that
the issues are present, and how best to address them.  Feel free
to tell me if this discussion should have its own thread, to not
end up in the review comments of a patch (although it's RFT).


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office-ynQEQJNshbs@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
