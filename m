Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFC2304BA3
	for <linux-spi@vger.kernel.org>; Thu,  2 Jul 2026 15:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783004891; cv=none; b=jt5nsGFZ8KzMxwqX8siwdI8kuk/C4CfsIWzcKcl9oPZSAJLg3yMFNkUpQrMQ1CNHsvaUW12+2BQZPcZ85p1u6Zf7U4T7Xf34gycMarH3R0+gSfACBRqEAe5ZHYQ0wEqVLB2fBgRNQt8EnR86LL0d1C6yuoQ+IHKGwTLPJqOeYso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783004891; c=relaxed/simple;
	bh=uRXk7IpS0wFu3ywjC32sSrvBhgbyOYWYQsk3/STViQQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jRzcePDt96zA3Hopstapy6WtCBuhTbuj26iV1eU+eplyiRss0sVn8cYvS9/MNHAbK+Hgtgw2i8RSegmFcdb9u0tdmmiC8FKv1qOYIDH84rV9rqpZHYFGKlaVA0xG0UITT8YC0EulqiNIDJeLxmukTAhqbh/ZEA8g3pirCfykUag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Cgb+nrv/; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Cgb+nrv/"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id BC5CE4E40C32;
	Thu,  2 Jul 2026 15:08:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7C8B75FF03;
	Thu,  2 Jul 2026 15:08:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F2B6C104C9546;
	Thu,  2 Jul 2026 17:08:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783004884; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=1F6WcObOnrqVzWCe6S/Ifbf3Oxz0U7OhbfWsObhKvwM=;
	b=Cgb+nrv/thIirZ882qafwmxhh7CtfuS++fJG7QYKjG4kOJhnLe7LtUlnUvr1Q5rNM8EpJP
	uvrcGu0WIkD7RMendKazlcQ3S67K+4x8cNTYNV64hrEajOnWVfQspJxjBjAkA4pAPS3wQB
	gIRoCHNaye50g22c0oJbFrobwtfhzojXLCLMZKjQIqsBSzk4yGOuEqyO/rgiBwZGRkgAS/
	kc8zJac8o2iaYWSFXcsuc/lhHe8ZaAqo6MaQEaQ2BRF+FgxF00Rhf+HG9P1UveMa0NkqkM
	TXuSgXwyJSfOT/t8GmAjOQ59o2aHOtsQBpT3ZmC0meoRff8V7vsBCv8O2rULNQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Santhosh Kumar K <s-k6@ti.com>
Cc: <broonie@kernel.org>,  <robh@kernel.org>,  <krzk+dt@kernel.org>,
  <conor+dt@kernel.org>,  <richard@nod.at>,  <vigneshr@ti.com>,
  <pratyush@kernel.org>,  <mwalle@kernel.org>,
  <takahiro.kuwano@infineon.com>,  <linux-spi@vger.kernel.org>,
  <devicetree@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,
  <linux-mtd@lists.infradead.org>,  <praneeth@ti.com>,  <u-kumar1@ti.com>,
  <a-dutta@ti.com>
Subject: Re: [PATCH v4 14/16] mtd: spinand: negotiate optimal PHY operating
 point before dirmap creation
In-Reply-To: <20260618073725.84733-15-s-k6@ti.com> (Santhosh Kumar K.'s
	message of "Thu, 18 Jun 2026 13:07:23 +0530")
References: <20260618073725.84733-1-s-k6@ti.com>
	<20260618073725.84733-15-s-k6@ti.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Thu, 02 Jul 2026 17:08:00 +0200
Message-ID: <87pl15pgz3.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On 18/06/2026 at 13:07:23 +0530, Santhosh Kumar K <s-k6@ti.com> wrote:

> Dirmap descriptors encode the op template including the operating
> frequency at creation time, so PHY tuning must complete before dirmaps
> are created to ensure the validated frequency is embedded in the
> descriptors from the start.

Good idea.

> Move dirmap creation from spinand_init() to spinand_probe(), after a
> new spinand_configure_phy()

Fine with the idea, but in the core I would like to avoid TI specific
naming. We can call this helper spinand_optimize_controller(); for
instance.

Please, do not use "PHY" in the SPI NAND core, because I find it too TI
specific and we need generic enough naming so that we can include other
controller's optimizations in this logic, if ever needed.

> call that negotiates the best available PHY
> operating point. spinand_configure_phy() tries the pre-selected variant
> first. If the controller signals that PHY tuning is not applicable for
> that op, spinand_try_phy_ranked() iterates remaining variants in
> performance order =E2=80=94 DTR variants first, then SDR variants after
> switching the bus interface if needed. On full failure the device falls
> back to the best available non-PHY mode.

Makes sense.

> Add spinand_reset_max_ops() to copy op templates with max_freq zeroed

spinand_reset_max_freq_ops()?

> before each execute_tuning call, enforcing the invariant that a non-zero
> max_freq only results from a successful tuning.
>
> PHY failure is non-fatal; the device operates at the conservative base
> rate.
>
> Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
> ---
>  drivers/mtd/nand/spi/core.c | 214 ++++++++++++++++++++++++++++++++++--
>  include/linux/mtd/spinand.h |  11 ++
>  2 files changed, 216 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> index b678d0534297..5dcfaabaf2cc 100644
> --- a/drivers/mtd/nand/spi/core.c
> +++ b/drivers/mtd/nand/spi/core.c
> @@ -1280,10 +1280,16 @@ static int spinand_create_dirmap(struct spinand_d=
evice *spinand,
>  	/* The plane number is passed in MSB just above the column address */
>  	info.offset =3D plane << fls(nand->memorg.pagesize);
>=20=20
> +	/*
> +	 * Propagate the validated PHY frequency into the dirmap op templates
> +	 * at construction time.
> +	 */
> +
>  	/* Write descriptor */
>  	info.length =3D nanddev_page_size(nand) + nanddev_per_page_oobsize(nand=
);
>  	info.primary_op_tmpl =3D *spinand->op_templates->update_cache;
>  	info.primary_op_tmpl.data.ecc =3D enable_ecc;
> +	info.primary_op_tmpl.max_freq =3D spinand->max_write_op.max_freq;
>  	desc =3D devm_spi_mem_dirmap_create(&spinand->spimem->spi->dev,
>  					  spinand->spimem, &info);
>  	if (IS_ERR(desc))
> @@ -1294,9 +1300,11 @@ static int spinand_create_dirmap(struct spinand_de=
vice *spinand,
>  	/* Read descriptor */
>  	info.primary_op_tmpl =3D *spinand->op_templates->read_cache;
>  	info.primary_op_tmpl.data.ecc =3D enable_ecc;
> +	info.primary_op_tmpl.max_freq =3D spinand->max_read_op.max_freq;
>  	if (secondary_op) {
>  		info.secondary_op_tmpl =3D *spinand->op_templates->cont_read_cache;
>  		info.secondary_op_tmpl.data.ecc =3D enable_ecc;
> +		info.secondary_op_tmpl.max_freq =3D spinand->max_read_op.max_freq;
>  	}
>  	desc =3D spinand_create_rdesc(spinand, &info);
>  	if (IS_ERR(desc))
> @@ -1744,6 +1752,17 @@ int spinand_match_and_init(struct spinand_device *=
spinand,
>  				spinand->cont_read_possible =3D false;
>  		}
>=20=20
> +		/*
> +		 * Save the full read variant list (ODTR and SSDR ops) for PHY
> +		 * tuning iteration. Only saved when all ODTR templates are
> +		 * valid so spinand_configure_phy() knows ranked fallback is
> +		 * available.
> +		 */
> +		if (spinand->odtr_op_templates.read_cache &&
> +		    spinand->odtr_op_templates.write_cache &&
> +		    spinand->odtr_op_templates.update_cache)
> +			spinand->phy_read_variants =3D info->op_variants.read_cache;
> +
>  		return 0;
>  	}
>=20=20
> @@ -1922,7 +1941,6 @@ static int spinand_mtd_suspend(struct mtd_info *mtd)
>=20=20
>  static int spinand_init(struct spinand_device *spinand)
>  {
> -	struct device *dev =3D &spinand->spimem->spi->dev;
>  	struct mtd_info *mtd =3D spinand_to_mtd(spinand);
>  	struct nand_device *nand =3D mtd_to_nanddev(mtd);
>  	int ret;
> @@ -2014,14 +2032,6 @@ static int spinand_init(struct spinand_device *spi=
nand)
>  	mtd->ecc_step_size =3D nanddev_get_ecc_conf(nand)->step_size;
>  	mtd->bitflip_threshold =3D DIV_ROUND_UP(mtd->ecc_strength * 3, 4);
>=20=20
> -	ret =3D spinand_create_dirmaps(spinand);
> -	if (ret) {
> -		dev_err(dev,
> -			"Failed to create direct mappings for read/write operations (err =3D =
%d)\n",
> -			ret);
> -		goto err_cleanup_ecc_engine;
> -	}
> -
>  	return 0;
>=20=20
>  err_cleanup_ecc_engine:
> @@ -2050,6 +2060,178 @@ static void spinand_cleanup(struct spinand_device=
 *spinand)
>  	kfree(spinand->scratchbuf);
>  }
>=20=20
> +/*
> + * spinand_try_phy_ranked() - Try PHY tuning on variants in performance =
order.
> + * @spinand:    SPI NAND device
> + * @mem:        SPI memory device
> + * @odtr:       true to iterate ODTR variants, false for SSDR variants
> + * @tried_mask: bitmask of already-tried variant indices; updated on eac=
h try
> + *
> + * Iterates the full read variant list in descending performance order,
> + * skipping variants in @tried_mask, and calls execute_tuning on each un=
til one
> + * succeeds. The fastest PHY-tunable variant is chosen regardless of whi=
ch was
> + * pre-selected at init; ranked iteration finds the best available varia=
nt
> + * without re-trying already-attempted ones.
> + *
> + * On success, sets spinand->max_read_op and updates the matching
> + * odtr_op_templates.read_cache or ssdr_op_templates.read_cache.
> + */
> +static bool spinand_try_phy_ranked(struct spinand_device *spinand,
> +				   struct spi_mem *mem, bool odtr,
> +				   u32 *tried_mask)
> +{
> +	const struct spinand_op_variants *variants =3D spinand->phy_read_varian=
ts;
> +	const struct spi_mem_op *best;
> +	int ret;
> +
> +	if (!variants)
> +		return false;
> +
> +	while ((best =3D spinand_op_find_best(spinand, variants, odtr,
> +					    *tried_mask))) {

Ok, now I get the mask.

Why do you care about odtr flag at all? We should just take the fastest
modes in descending order, I don't really understand why mentioning odtr
is needed? Maybe your goal is to make a faster loop, taking the fastest
mode in each case and compare? This should work in most cases, given the
fact that we tend to order the variants by speed, but they are not
always in perfect order. I already faced cases where faster modes
appeared to be down the list because of the game of dummy cycles. But
that is probably not impacting PHY mode since we are using the fastest
speed (with only the mode with the maximum number of dummy cycles)
usable.

So in the end, if you sort ODTR vs. SSDR for optimization reasons, ok.

> +		*tried_mask |=3D BIT(best - variants->ops);
> +		spinand->max_read_op =3D *best;
> +		spinand->max_read_op.max_freq =3D 0;
> +		ret =3D spi_mem_execute_tuning(mem, &spinand->max_read_op,
> +					     &spinand->max_write_op);
> +		if (ret && ret !=3D -EOPNOTSUPP)
> +			dev_warn(&mem->spi->dev, "%s PHY tuning failed: %d\n",
> +				 odtr ? "ODTR" : "SSDR", ret);
> +		if (!ret && spinand->max_read_op.max_freq) {
> +			if (odtr)
> +				spinand->odtr_op_templates.read_cache =3D best;
> +			else
> +				spinand->ssdr_op_templates.read_cache =3D best;
> +			return true;
> +		}
> +	}
> +	return false;
> +}
> +
> +/*
> + * spinand_reset_max_ops() - Copy op templates and zero max_freq on both.
> + * @spinand:    SPI NAND device
> + * @templates:  op template set to copy from
> + *
> + * Called before execute_tuning so max_freq starts at zero; execute_tuni=
ng sets
> + * it to the validated clock rate only on success. A non-zero max_freq m=
eans
> + * PHY-validated; zero means the base rate applies.
> + */
> +static void spinand_reset_max_ops(struct spinand_device *spinand,
> +				  struct spinand_mem_ops *templates)
> +{
> +	spinand->max_read_op =3D *templates->read_cache;
> +	spinand->max_read_op.max_freq =3D 0;
> +	spinand->max_write_op =3D *templates->write_cache;
> +	spinand->max_write_op.max_freq =3D 0;
> +}
> +
> +/*
> + * spinand_configure_phy() - Negotiate the optimal PHY operating point.
> + * @spinand:    SPI NAND device
> + * @mem:        SPI memory device
> + *
> + * Tries the pre-selected variant first.  If the controller signals that
> + * PHY tuning is not applicable for that specific op, iterates all remai=
ning
> + * variants in performance order.  For devices that support both DTR and=
 SDR
> + * interfaces, DTR variants are tried first; if all fail the device is
> + * switched to SDR mode and SDR variants are tried.  On full failure the
> + * device falls back to the best available non-PHY mode.  Devices that
> + * support only SDR skip the DTR ranked pass entirely.
> + *
> + * PHY failure is never fatal.
> + *
> + * Note: tried_mask is u32, supporting up to 32 variants total across bo=
th
> + * ODTR and SSDR. Flash devices with more than 32 read variants are not
> + * supported.
> + */
> +static void spinand_configure_phy(struct spinand_device *spinand,
> +				  struct spi_mem *mem)
> +{
> +	u32 tried_mask;
> +	int ret;
> +
> +	spinand_reset_max_ops(spinand, spinand->op_templates);
> +
> +	ret =3D spi_mem_execute_tuning(mem, &spinand->max_read_op,
> +				     &spinand->max_write_op);
> +	if (ret && ret !=3D -EOPNOTSUPP)
> +		dev_warn(&mem->spi->dev, "Failed to execute PHY tuning: %d\n",
> +			 ret);

I guess we don't want to warn in this case. You can keep it as a dbg log
if you want.

> +	/*
> +	 * Any non-zero return or a set max_freq means we are done (error,
> +	 * unsupported, or success). Fallback only for the op-specific "skip"
> +	 * signal: ret =3D=3D 0 with max_freq still 0.
> +	 */
> +	if (ret || spinand->max_read_op.max_freq)
> +		return;
> +
> +	if (!mem->spi->post_config_max_speed_hz || spinand->bus_iface =3D=3D SS=
DR ||
> +	    !spinand->phy_read_variants)
> +		return;

Why not moving this earlier? (except the SSDR check) this way we return
even earlier if the tuning cannot happen.

I am not sure I understand your use of phy_read_variants here. Can it
really be NULL?

> +	if (WARN_ON(spinand->phy_read_variants->nops > 32))
> +		return;
> +
> +	/* Mark the pre-selected ODTR variant as already tried */
> +	tried_mask =3D BIT(spinand->odtr_op_templates.read_cache -
> +			 spinand->phy_read_variants->ops);
> +
> +	dev_dbg(&mem->spi->dev,
> +		"PHY tuning skipped for current op; searching for best PHY variant\n");
> +
> +	/* Pass 1: try all remaining ODTR variants in performance order */
> +	if (spinand_try_phy_ranked(spinand, mem, true, &tried_mask))
> +		return;
> +
> +	/*
> +	 * Pass 2: switch to SSDR and try all SSDR variants in performance
> +	 * order.
> +	 *
> +	 * Only enter if we actually have SSDR support and a reconfigure
> +	 * callback.

It is not possible to enable ODTR without the configure callback.

> The hardware is still in ODTR mode here so no
> +	 * configure_chip call is needed to undo; just set up the ODTR non-PHY
> +	 * fallback and return.
> +	 */
> +	if (!spinand->ssdr_op_templates.read_cache ||
> +	    !spinand->ssdr_op_templates.write_cache ||

I don't think this is ever possible, is it?

> +	    !spinand->configure_chip)
> +		goto use_odtr_non_phy;

I don't think we will ever use this path.

> +
> +	if (spinand->configure_chip(spinand, SSDR))
> +		goto use_odtr_non_phy;

We should handle chips with no ODTR support. I'm not sure the logic is
robust enough for them. Have you tried by commenting out the ODTR
variants of your chip?

> +
> +	spinand->op_templates =3D &spinand->ssdr_op_templates;
> +	spinand->bus_iface =3D SSDR;
> +	spinand->max_write_op =3D *spinand->ssdr_op_templates.write_cache;
> +	spinand->max_write_op.max_freq =3D 0;
> +
> +	/*
> +	 * Only ODTR variants were candidates in Pass 1; SSDR bit positions
> +	 * are clear
> +	 */
> +	if (spinand_try_phy_ranked(spinand, mem, false, &tried_mask))
> +		return;
> +
> +	/*
> +	 * All PHY attempts exhausted.  Revert to ODTR for non-PHY DTR
> +	 * operation.  If revert fails, stay in SSDR =E2=80=94 a mode mismatch
> +	 * (ODTR op templates on SSDR-mode device) would corrupt data.
> +	 */
> +	if (spinand->configure_chip(spinand, ODTR)) {
> +		dev_warn(&mem->spi->dev,
> +			 "Failed to revert to ODTR, staying in SSDR non-PHY\n");
> +		spinand_reset_max_ops(spinand, &spinand->ssdr_op_templates);
> +		return;
> +	}
> +
> +use_odtr_non_phy:
> +	spinand->op_templates =3D &spinand->odtr_op_templates;
> +	spinand->bus_iface =3D ODTR;
> +	spinand_reset_max_ops(spinand, &spinand->odtr_op_templates);
> +}

>  static int spinand_probe(struct spi_mem *mem)
>  {
>  	struct spinand_device *spinand;
> @@ -2072,6 +2254,20 @@ static int spinand_probe(struct spi_mem *mem)
>  	if (ret)
>  		return ret;
>=20=20
> +	/*
> +	 * Negotiate the best PHY operating point before creating dirmaps so
> +	 * the validated frequency is available at dirmap construction time.
> +	 */
> +	spinand_configure_phy(spinand, mem);
> +
> +	ret =3D spinand_create_dirmaps(spinand);
> +	if (ret) {
> +		dev_err(&mem->spi->dev,
> +			"Failed to create direct mappings for read/write operations (err =3D =
%d)\n",
> +			ret);
> +		goto err_spinand_cleanup;
> +	}
> +
>  	ret =3D mtd_device_register(mtd, NULL, 0);
>  	if (ret)
>  		goto err_spinand_cleanup;
> diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
> index ec6efcfeef83..50a8319cf11e 100644
> --- a/include/linux/mtd/spinand.h
> +++ b/include/linux/mtd/spinand.h
> @@ -791,8 +791,19 @@ struct spinand_device {
>  	struct spinand_mem_ops *op_templates;
>  	enum spinand_bus_interface bus_iface;
>=20=20
> +	/*
> +	 * Full read variant list (ODTR and SSDR ops together), saved when ODTR
> +	 * templates are valid. Used by spinand_configure_phy() to iterate all
> +	 * candidates when the pre-selected variant cannot be PHY-tuned.
> +	 */
> +	const struct spinand_op_variants *phy_read_variants;

Why do you prefix this pointer name with "phy"? The variants pointed are
basically all read variants, no more no less. Even though you want to
use them for PHY tuning purposes, I don't think it is wise to name the
member here.

> +
>  	struct spinand_dirmap *dirmaps;
>=20=20
> +	/* Persistent op templates updated by execute_tuning with validated spe=
ed. */
> +	struct spi_mem_op max_read_op;
> +	struct spi_mem_op max_write_op;
> +
>  	int (*select_target)(struct spinand_device *spinand,
>  			     unsigned int target);
>  	unsigned int cur_target;

Thanks,
Miqu=C3=A8l
