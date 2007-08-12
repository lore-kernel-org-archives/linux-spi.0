From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [patch 3/4 2.6.23-rc2 + mm2-git-mmc] MMC
	core learns about SPI
Date: Sun, 12 Aug 2007 08:50:03 -0700
Message-ID: <200708120850.04271.david-b@pacbell.net>
References: <200708080906.18993.david-b@pacbell.net>
	<200708080911.33099.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Mikael Starvik <mikael.starvik-VrBV9hrLPhE@public.gmane.org>,
	Hans-Peter Nilsson <hans-peter.nilsson-VrBV9hrLPhE@public.gmane.org>,
	Mike Lavender <mike-UTnDXsALFwNjMdQLN6DIHgC/G2K4zDHf@public.gmane.org>
To: Pierre Ossman <drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200708080911.33099.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

This wasn't merged correctly into 2.6.23-rc2-mm2's version of git-mmc,
and that goof guarantees oopsing while enumerating at least SD-cards.

When the merge botch is fixed, that version of git-mmc.patch passes
sanity testing with MMC-over-SPI.


On Wednesday 08 August 2007, David Brownell wrote:
>
>	...
>
> --- g26.orig/drivers/mmc/core/mmc_ops.c=A02007-08-08 09:07:48.000000000 -=
0700
> +++ g26/drivers/mmc/core/mmc_ops.c=A0=A0=A0=A0=A0=A02007-08-08 09:07:57.0=
00000000 -0700
>
>	...
>
> @@ -206,21 +229,31 @@ int mmc_send_ext_csd(struct mmc_card *ca
> =A0=A0=A0=A0=A0=A0=A0=A0mrq.cmd =3D &cmd;
> =A0=A0=A0=A0=A0=A0=A0=A0mrq.data =3D &data;
> =A0
> -=A0=A0=A0=A0=A0=A0=A0cmd.opcode =3D MMC_SEND_EXT_CSD;
> +=A0=A0=A0=A0=A0=A0=A0cmd.opcode =3D opcode;
> =A0=A0=A0=A0=A0=A0=A0=A0cmd.arg =3D 0;
> -=A0=A0=A0=A0=A0=A0=A0cmd.flags =3D MMC_RSP_R1 | MMC_CMD_ADTC;
> =A0
> -=A0=A0=A0=A0=A0=A0=A0data.blksz =3D 512;
> +=A0=A0=A0=A0=A0=A0=A0/* NOTE HACK: =A0the MMC_RSP_SPI_R1 is always corre=
ct here, but we
> +=A0=A0=A0=A0=A0=A0=A0 * rely on callers to never use this with "native" =
calls for reading
> +=A0=A0=A0=A0=A0=A0=A0 * CSD or CID. =A0Native versions of those commands=
 use the R2 type,
> +=A0=A0=A0=A0=A0=A0=A0 * not R1 plus a data block.
> +=A0=A0=A0=A0=A0=A0=A0 */
> +=A0=A0=A0=A0=A0=A0=A0cmd.flags =3D MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD=
_ADTC;
> +
> +=A0=A0=A0=A0=A0=A0=A0data.blksz =3D len;
> =A0=A0=A0=A0=A0=A0=A0=A0data.blocks =3D 1;
> =A0=A0=A0=A0=A0=A0=A0=A0data.flags =3D MMC_DATA_READ;
> =A0=A0=A0=A0=A0=A0=A0=A0data.sg =3D &sg;
> =A0=A0=A0=A0=A0=A0=A0=A0data.sg_len =3D 1;
> =A0
> -=A0=A0=A0=A0=A0=A0=A0sg_init_one(&sg, ext_csd, 512);
> +=A0=A0=A0=A0=A0=A0=A0sg_init_one(&sg, data_buf, len);
> =A0
> -=A0=A0=A0=A0=A0=A0=A0mmc_set_data_timeout(&data, card);
> +=A0=A0=A0=A0=A0=A0=A0if (card)
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0mmc_set_data_timeout(&data,=
 card);
> =A0
> -=A0=A0=A0=A0=A0=A0=A0mmc_wait_for_req(card->host, &mrq);
> +=A0=A0=A0=A0=A0=A0=A0mmc_wait_for_req(host, &mrq);

The line above was merged as "mmc_wait_for_req(card->host, &mrq);" ...

Note the preceding "if (card) ...".  When "card" is null, as it
usually is during SPI enumeration, this always oopses.


> +
> +=A0=A0=A0=A0=A0=A0=A0memcpy(buf, data_buf, len);
> +=A0=A0=A0=A0=A0=A0=A0kfree(data_buf);
> =A0
> =A0=A0=A0=A0=A0=A0=A0=A0if (cmd.error)
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return cmd.error;



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
