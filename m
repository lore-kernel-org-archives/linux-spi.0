From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V2 2/5] spi: core: add spi_replace_transfers method
Date: Fri, 11 Dec 2015 16:37:32 +0200
Message-ID: <CAHp75Vd_7NBibKFPq++JuDiWp9zkwu9iPrjZyKK6XoL6Lr_S0g@mail.gmail.com>
References: <1449501708-2228-1-git-send-email-kernel@martin.sperl.org>
	<1449501708-2228-3-git-send-email-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1449501708-2228-3-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Mon, Dec 7, 2015 at 5:21 PM,  <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org> wrote:
> From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
>
> Add the spi_replace_transfers method that can get used
> to replace some spi_transfers from a spi_message with other
> transfers.

=46ew more implementation comments.

>
> Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
> ---
>  drivers/spi/spi.c       |  130 +++++++++++++++++++++++++++++++++++++=
++++++++++
>  include/linux/spi/spi.h |   44 ++++++++++++++++
>  2 files changed, 174 insertions(+)
>
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index fb39d23..97c77b3 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -2087,6 +2087,136 @@ EXPORT_SYMBOL_GPL(spi_res_release);
>
>  /*------------------------------------------------------------------=
-------*/
>
> +/* Core methods for spi_message alterations */
> +
> +static void __spi_replace_transfers_release(struct spi_master *maste=
r,
> +                                           struct spi_message *msg,
> +                                           void *res)
> +{
> +       struct spi_replaced_transfers *srt =3D res;

srt sounds magic
rxfer might be better?

> +       int i;

unsigned int i; or size_t to be in align with inserted field.

> +
> +       /* call extra callback if requested */
> +       if (srt->release)
> +               srt->release(master, msg, res);
> +
> +       /* insert replaced transfers back into the message */
> +       list_splice(&srt->replaced_transfers, srt->replaced_after);
> +
> +       /* remove the formerly inserted entries */
> +       for (i =3D 0; i < srt->inserted; i++)
> +               list_del(&srt->inserted_transfers[i].transfer_list);
> +}
> +
> +/**
> + * spi_replace_transfers - replace transfers with several transfers
> + *                         and register change with spi_message.reso=
urces
> + * @msg:           the spi_message we work upon
> + * @xfer_first:    the first spi_transfer we want to replace
> + * @remove:        number of transfers to remove
> + * @insert:        the number of transfers we want to insert instead
> + * @release:       extra release code necessary in some circumstance=
s
> + * @extradatasize: extra data to allocate (with alignment guarantees
> + *                 of struct @spi_transfer)
> + *
> + * Returns: pointer to @spi_replaced_transfers,
> + *          NULL in case of errors
> + */
> +struct spi_replaced_transfers *spi_replace_transfers(
> +       struct spi_message *msg,
> +       struct spi_transfer *xfer_first,
> +       size_t remove,
> +       size_t insert,
> +       spi_replaced_release_t release,
> +       size_t extradatasize)
> +{
> +       struct spi_replaced_transfers *srt;
> +       int i;

Ditto.

> +
> +       /* allocate the structure using spi_res */
> +       srt =3D spi_res_alloc(msg->spi, __spi_replace_transfers_relea=
se,
> +                           insert * sizeof(struct spi_transfer)
> +                           + sizeof(struct spi_replaced_transfers)
> +                           + extradatasize,
> +                           0);
> +       if (!srt)
> +               return NULL;

ERR_PTR for this API seems better to have.

> +
> +       /* the release code to invoke before running the generic rele=
ase */
> +       srt->release =3D release;
> +
> +       /* assign extradata */
> +       if (extradatasize)
> +               srt->extradata =3D &srt->inserted_transfers[srt->inse=
rted];
> +
> +       /* init the replaced_transfers list */
> +       INIT_LIST_HEAD(&srt->replaced_transfers);
> +
> +       /* assign the list_entry after which we should reinsert
> +        * the @replaced_transfers - it may be spi_message.messages!
> +        */
> +       srt->replaced_after =3D xfer_first->transfer_list.prev;
> +
> +       /* remove the requested number of transfers */
> +       for (i =3D 0; i < remove; i++) {
> +               /* if the entry after replaced_after it is msg->trans=
fers
> +                * then we have been requested to remove more transfe=
rs
> +                * than are in the list
> +                */
> +               if (srt->replaced_after->next =3D=3D &msg->transfers)=
 {
> +                       dev_err(&msg->spi->dev,
> +                               "requested to remove more spi_transfe=
rs than are available\n");
> +                       /* insert replaced transfers back into the me=
ssage */
> +                       list_splice(&srt->replaced_transfers,
> +                                   srt->replaced_after);
> +
> +                       /* free the spi_replace_transfer structure */
> +                       spi_res_free(srt);
> +
> +                       /* and return with an error */
> +                       return NULL;
> +               }
> +
> +               /* remove the entry after replaced_after from list of
> +                * transfers and add it to list of replaced_transfers
> +                */
> +               list_move_tail(srt->replaced_after->next,
> +                              &srt->replaced_transfers);
> +       }
> +
> +       /* create copy of the given xfer with identical settings
> +        * based on the first transfer to get removed
> +        * note that we run in reverse to keep the array order
> +        * match the order in transfer_list
> +        */
> +       srt->inserted =3D insert;
> +       for (i =3D insert - 1; i >=3D 0 ; i--) {

This is classical pattern for

while (--insert >=3D 0) {
}

> +               /* copy all spi_transfer data */
> +               memcpy(&srt->inserted_transfers[i], xfer_first,
> +                      sizeof(*xfer_first));
> +
> +               /* for all but the last inserted_transfer,
> +                * clear some settings
> +                */
> +               if (i < insert - 1) {

=E2=80=A6and
if (insert) {
}


> +                       srt->inserted_transfers[i].cs_change =3D 0;
> +                       srt->inserted_transfers[i].delay_usecs =3D 0;
> +               }
> +
> +               /* add after srt->replaced_after */
> +               list_add(&srt->inserted_transfers[i].transfer_list,
> +                        srt->replaced_after);
> +       }
> +
> +       /* and register it with spi_res/spi_message */
> +       spi_res_add(msg, srt);
> +
> +       return srt;
> +}
> +EXPORT_SYMBOL_GPL(spi_replace_transfers);
> +
> +/*------------------------------------------------------------------=
-------*/
> +
>  /* Core methods for SPI master protocol drivers.  Some of the
>   * other core methods are currently defined as inline functions.
>   */
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index 7e74e0e..35b5f17 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -875,6 +875,50 @@ extern int spi_async_locked(struct spi_device *s=
pi,
>
>  /*------------------------------------------------------------------=
---------*/
>
> +/* SPI transfer replacement methods which make use of spi_res */
> +
> +/**
> + * struct spi_replaced_transfers - structure describing the spi_tran=
sfer
> + *                                 replacements that have occurred
> + *                                 so that they can get reverted
> + * @release:            some extra release code to get executed prio=
r to
> + *                      relasing this structure
> + * @extradata:          pointer to some extra data if requested or N=
ULL
> + * @replaced_transfers: transfers that have been replaced and which =
need
> + *                      to get restored
> + * @replaced_after:     the transfer after which the @replaced_trans=
fers
> + *                      are to get re-inserted
> + * @inserted:           number of transfers inserted
> + * @inserted_transfers: array of spi_transfers of array-size @insert=
ed,
> + *                      that have been replacing replaced_transfers
> + *
> + * note: that @extradata will point to @inserted_transfers[@inserted=
]
> + * if some extra allocation is requested, so alignment will be the s=
ame
> + * as for spi_transfers
> + */
> +struct spi_replaced_transfers;
> +typedef void (*spi_replaced_release_t)(struct spi_master *master,
> +                                      struct spi_message *msg,
> +                                      struct spi_replaced_transfers =
*res);
> +struct spi_replaced_transfers {
> +       spi_replaced_release_t release;
> +       void *extradata;
> +       struct list_head replaced_transfers;
> +       struct list_head *replaced_after;
> +       size_t inserted;
> +       struct spi_transfer inserted_transfers[];
> +};
> +
> +extern struct spi_replaced_transfers *spi_replace_transfers(
> +       struct spi_message *msg,
> +       struct spi_transfer *xfer_first,
> +       size_t remove,
> +       size_t insert,
> +       spi_replaced_release_t release,
> +       size_t extradatasize);
> +
> +/*------------------------------------------------------------------=
---------*/
> +
>  /* All these synchronous SPI transfer routines are utilities layered
>   * over the core async transfer primitive.  Here, "synchronous" mean=
s
>   * they will sleep uninterruptibly until the async transfer complete=
s.
> --
> 1.7.10.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-spi" =
in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
With Best Regards,
Andy Shevchenko
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
