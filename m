From: Daniel Walker <dwalker@mvista.com>
Subject: Re: [PATCH v3 4/4] powerpc/mpc5200: Add mpc5200-spi (non-PSC)
	device driver
Date: Fri, 25 Jul 2008 14:19:14 -0400
Message-ID: <1217009954.13539.23.camel@localhost.localdomain>
References: <20080725072549.8485.90723.stgit@trillian.secretlab.ca>
	<20080725073326.8485.99210.stgit@trillian.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: dbrownell@users.sourceforge.net, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, spi-devel-general@lists.sourceforge.net,
	akpm@linux-foundation.org
To: Grant Likely <grant.likely@secretlab.ca>
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <20080725073326.8485.99210.stgit@trillian.secretlab.ca>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
List-Id: linux-spi.vger.kernel.org

On Fri, 2008-07-25 at 03:33 -0400, Grant Likely wrote:

> +	if (status && (irq != NO_IRQ))
> +		dev_err(&ms->master->dev, "spurious irq, status=0x%.2x\n",
> +			status);
> +
> +	/* Check if there is another transfer waiting */
> +	if (list_empty(&ms->queue))
> +		return FSM_STOP;

I don't think doing list_empty outside the critical section is totally
safe.. You might want to move it down inside the spin_lock() section.

> +	/* Get the next message */
> +	spin_lock(&ms->lock);

The part that's a little confusing here is that the interrupt can
actually activate the workqueue .. So I'm wondering if maybe you could
have this interrupt driven any workqueue driven at the same time? If you
could then you would need the above to be 
spin_lock_irq/spin_lock_irqsave ..

Daniel
