Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B321A3B9616
	for <linux-spi@vger.kernel.org>; Wed, 25 Mar 2026 10:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774433907; cv=none; b=j403jNmqjQGdy6h2xs4QTb0EoK6rU7hDAV4+bicaQiQDtbFFmBe0BKwX/7FiSs5yRuXVuG1LrnQLW67pew03hsMPdUJdvHNnqQg7hNU84WJpZipdy1esDttNTBVSwkcO1baUwPm/pNvurlB58C7d7JX08gBcJl25UwjLZl+9JXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774433907; c=relaxed/simple;
	bh=1Uc6t1cwxW0MzD1dqSUvlR5rqITAHKLiUYzFlCfYbCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UNFAp2hxIQmBJXxd8t+1mQ5CUUQqv+WELKVI4CQ37mFIWXwOWHeXC9ZHZnH0nofPuoNKUsT4xe4gCfIVZ+t7vXrXFCCdhTZGd6YC6HlO3u05UhevhuGLKSqLP7JS5HkR3bubV2k1PJ5mImRb7xDu/h2kqX5e5UDN6uwh4FFvXsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jHOZW0NK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jHOZW0NK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774433902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HBOh/aoPlGxYDPbqkk5UK0G4/ytz0Hu0GxFXOarsu9g=;
	b=jHOZW0NK4ph+nCIJtYbvMbiUxhKSecQKP3lRboTMJ/wC/susilImFdkTeVMDXxSLG97Nar
	W+vkI4YrRS5PUnC/g/l7L9/ukhyoOe+IvvcZPz/qLET2y2XH2OghLxBMNgbO9aN/8pxbXp
	AnPtpPyYDcfF17Ftp3L2xu1ISskNauM=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-Q6AXVU0-O72_MvsE9vwnRA-1; Wed, 25 Mar 2026 06:18:21 -0400
X-MC-Unique: Q6AXVU0-O72_MvsE9vwnRA-1
X-Mimecast-MFC-AGG-ID: Q6AXVU0-O72_MvsE9vwnRA_1774433901
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-7986f771f69so19576567b3.1
        for <linux-spi@vger.kernel.org>; Wed, 25 Mar 2026 03:18:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774433901; x=1775038701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HBOh/aoPlGxYDPbqkk5UK0G4/ytz0Hu0GxFXOarsu9g=;
        b=FepE57O8k7M+wDhzaUwpuRqOx1K9rSErc9RvNSwy63yasGXfVrMrk6Bo9UkeIdAQlc
         NEmMmQd1Cb+eXPtaFnTgcorX8NAhM8evaUt+KK2imXI3vO6JhrXdeL/QuEJvPLeESjj1
         8SQQn08Y/lF/LRMxp3/mGfXI7V35L8qFcxutBt+m+FayGc97QHBfmlCUNKRHPaMnk0X3
         7AaDWQ9h45Px4mbBQ7XunpnOb6NYWTXSOi+yeIDLhLbDzNQgNNjd7kly49NbJzV1Xef5
         HKAutDo3qMdxgEHfd6df2hGkL82Ihmc5yVfSArjB1+zV7s0YmzUjBNuaMMqOy1kIv/Q9
         KOSA==
X-Forwarded-Encrypted: i=1; AJvYcCUTKw+aZyyo/Re6YnwlJ9U4PDO/nth+hkc6vzOpyP1ermIRuhbo7xXrCSKg8vXzcedHXaVHEQ0rarU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXfOrTY0vLNZMiB3WvyfhL1OIADpt/RKPb9CLIuX7/nqPZS3Ts
	E4i1Avtc2aK7epq+123g//CSnKILvxgxH1ohPOKCSODjNd3/mscehpmc5qrqK9C3JJfLij9993Q
	4uUeOQDZtoN2kS0Bol32aLxmTQfe21Y9McmttqCYmfU+Nnc6pco0FLk+J+MJmflMhVb8kFhzNmM
	htKgQIRACrpyP9SZJNF4aYCADRtigbDkrFz/Fy
X-Gm-Gg: ATEYQzzblaBsuVoAD12F3aT5tRUm5IIgBSZyTc2siDDwHsXcsVJC+H+frafbr1En9RP
	swlwfUTyTt2SzWvxuqjtwJgmLeG025oTdrtGqgirHLO2SCthE/o8SOYVGb+mydMLANH3WJMGBbv
	IQkKDWHQk6oP4jXGV1CFPNllSQVQ9aR3wRSq8eCOky5OXZDW8Y34SwOdiEqUqEYM5wPyd5PzEVp
	omFmw==
X-Received: by 2002:a53:acd1:0:20b0:64c:9f60:19d4 with SMTP id 956f58d0204a3-64ed77ef1ecmr4805302d50.8.1774433900769;
        Wed, 25 Mar 2026 03:18:20 -0700 (PDT)
X-Received: by 2002:a53:acd1:0:20b0:64c:9f60:19d4 with SMTP id
 956f58d0204a3-64ed77ef1ecmr4805242d50.8.1774433900219; Wed, 25 Mar 2026
 03:18:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324005919.2408620-1-dakr@kernel.org> <20260324005919.2408620-9-dakr@kernel.org>
In-Reply-To: <20260324005919.2408620-9-dakr@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 25 Mar 2026 11:17:43 +0100
X-Gm-Features: AaiRm50qMzjkKEJ7Fkr-Roi7I1a_DrzOw3E963yu_3LAy7xQt4ygKXGG9Px12Pc
Message-ID: <CAJaqyWeuvD+XntgE9q4epQELpYYTOs1CznFn_tuOxeh_LurrcA@mail.gmail.com>
Subject: Re: [PATCH 08/12] vdpa: use generic driver_override infrastructure
To: Danilo Krummrich <dakr@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Ioana Ciornei <ioana.ciornei@nxp.com>, 
	Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Armin Wolf <W_Armin@gmx.de>, 
	Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, 
	Vineeth Vijayan <vneethv@linux.ibm.com>, Peter Oberparleiter <oberpar@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Harald Freudenberger <freude@linux.ibm.com>, 
	Holger Dengler <dengler@linux.ibm.com>, Mark Brown <broonie@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Alex Williamson <alex@shazbot.org>, 
	Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, linux-kernel@vger.kernel.org, 
	driver-core@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-spi@vger.kernel.org, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org, xen-devel@lists.xenproject.org, 
	linux-arm-kernel@lists.infradead.org, Gui-Dong Han <hanguidong02@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FLLnlGcCzO9BZLiaZSTsarL1wne4uh5DwyjVkiodlyc_1774433901
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 2:00=E2=80=AFAM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> When a driver is probed through __driver_attach(), the bus' match()
> callback is called without the device lock held, thus accessing the
> driver_override field without a lock, which can cause a UAF.
>
> Fix this by using the driver-core driver_override infrastructure taking
> care of proper locking internally.
>
> Note that calling match() from __driver_attach() without the device lock
> held is intentional. [1]
>
> Link: https://lore.kernel.org/driver-core/DGRGTIRHA62X.3RY09D9SOK77P@kern=
el.org/ [1]
> Reported-by: Gui-Dong Han <hanguidong02@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D220789
> Fixes: 539fec78edb4 ("vdpa: add driver_override support")
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  drivers/vdpa/vdpa.c  | 48 +++++---------------------------------------
>  include/linux/vdpa.h |  4 ----
>  2 files changed, 5 insertions(+), 47 deletions(-)
>

Consolidate this logic is great, thanks!

> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 34874beb0152..caf0ee5d6856 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -67,57 +67,20 @@ static void vdpa_dev_remove(struct device *d)
>
>  static int vdpa_dev_match(struct device *dev, const struct device_driver=
 *drv)
>  {
> -       struct vdpa_device *vdev =3D dev_to_vdpa(dev);
> +       int ret;
>
>         /* Check override first, and if set, only use the named driver */
> -       if (vdev->driver_override)
> -               return strcmp(vdev->driver_override, drv->name) =3D=3D 0;
> +       ret =3D device_match_driver_override(dev, drv);
> +       if (ret >=3D 0)
> +               return ret;
>
>         /* Currently devices must be supported by all vDPA bus drivers */
>         return 1;

Nit: Maybe all of this can be replaced by
abs(device_match_driver_override(dev,drv))? Or maybe we're putting too
much in the same line.

Either way,

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!




>  }
>
> -static ssize_t driver_override_store(struct device *dev,
> -                                    struct device_attribute *attr,
> -                                    const char *buf, size_t count)
> -{
> -       struct vdpa_device *vdev =3D dev_to_vdpa(dev);
> -       int ret;
> -
> -       ret =3D driver_set_override(dev, &vdev->driver_override, buf, cou=
nt);
> -       if (ret)
> -               return ret;
> -
> -       return count;
> -}
> -
> -static ssize_t driver_override_show(struct device *dev,
> -                                   struct device_attribute *attr, char *=
buf)
> -{
> -       struct vdpa_device *vdev =3D dev_to_vdpa(dev);
> -       ssize_t len;
> -
> -       device_lock(dev);
> -       len =3D sysfs_emit(buf, "%s\n", vdev->driver_override);
> -       device_unlock(dev);
> -
> -       return len;
> -}
> -static DEVICE_ATTR_RW(driver_override);
> -
> -static struct attribute *vdpa_dev_attrs[] =3D {
> -       &dev_attr_driver_override.attr,
> -       NULL,
> -};
> -
> -static const struct attribute_group vdpa_dev_group =3D {
> -       .attrs  =3D vdpa_dev_attrs,
> -};
> -__ATTRIBUTE_GROUPS(vdpa_dev);
> -
>  static const struct bus_type vdpa_bus =3D {
>         .name  =3D "vdpa",
> -       .dev_groups =3D vdpa_dev_groups,
> +       .driver_override =3D true,
>         .match =3D vdpa_dev_match,
>         .probe =3D vdpa_dev_probe,
>         .remove =3D vdpa_dev_remove,
> @@ -132,7 +95,6 @@ static void vdpa_release_dev(struct device *d)
>                 ops->free(vdev);
>
>         ida_free(&vdpa_index_ida, vdev->index);
> -       kfree(vdev->driver_override);
>         kfree(vdev);
>  }
>
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index 2bfe3baa63f4..782c42d25db1 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -72,9 +72,6 @@ struct vdpa_mgmt_dev;
>   * struct vdpa_device - representation of a vDPA device
>   * @dev: underlying device
>   * @vmap: the metadata passed to upper layer to be used for mapping
> - * @driver_override: driver name to force a match; do not set directly,
> - *                   because core frees it; use driver_set_override() to
> - *                   set or clear it.
>   * @config: the configuration ops for this device.
>   * @map: the map ops for this device
>   * @cf_lock: Protects get and set access to configuration layout.
> @@ -90,7 +87,6 @@ struct vdpa_mgmt_dev;
>  struct vdpa_device {
>         struct device dev;
>         union virtio_map vmap;
> -       const char *driver_override;
>         const struct vdpa_config_ops *config;
>         const struct virtio_map_ops *map;
>         struct rw_semaphore cf_lock; /* Protects get/set config */
> --
> 2.53.0
>

