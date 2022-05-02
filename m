Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D05EC433EF
	for <linux-spi@archiver.kernel.org>; Mon,  2 May 2022 09:44:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351174AbiEBJrr (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 2 May 2022 05:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233354AbiEBJrl (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 2 May 2022 05:47:41 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E2C3AF;
        Mon,  2 May 2022 02:44:09 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id m25so808396oih.2;
        Mon, 02 May 2022 02:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pnp0dZNJNQtkrDucRNkaTQQYBUFrJbIosraQIj5ohy0=;
        b=i3wZpUdR58bPbFpeMankAbhAODtoyJIjIau7booB4ooQTz9g78/2H+UE3xj6giYZMz
         /flR2RT7oYyHwyVl5lcIdrK4IJ0BkWQJC54zLDhRKRbuh3Cxm7MaYj7odONMYrgLaq31
         BKRFhcCT02UTIlj26pHaiDSRbc5ll/ffA7e6gXlo+r0rE9SVhISwyA3OqL3Wx9f2X7vT
         qIs/N4ff1mfMy3nb8dEmgh98zB/+4/zsqq/hA7UROzQFfvkCImvd++RfsSACI+usaMup
         Bjzvt1u0nnRKlA/FfJN0S/41DMAi1D7GKCwHJLlu10FfpSXOB9Nh5/eRIagyfbzQ7fFB
         m2MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pnp0dZNJNQtkrDucRNkaTQQYBUFrJbIosraQIj5ohy0=;
        b=ckC3fBKN/1vbHnbNibiLPgDXiX/Uuv4FImA0Q/YaeZ2SEqX4YBLMdHnW2VHshThREA
         aHVTOu9WIviSnC0sVq0ReGqEq++1KpxBY/X/IyRjLmXVPRLruOlxR/vzbMWtPHuRQAUe
         zFfTXuaeSsfFDsmEcUjujOhLtey0glOLfDlF70M4oNllTJmaN5Fg7OWf639lNb6WY3en
         nq+NnfU84dde/9BlPg3EMLlkzXLyMEJ0wMsDAQpLtfFzvvOmnFpZgtIRcK9pMIbSqMkT
         L3+6uiIK9LnhhCh3NyjRjPLo19xCAHfLUjPzjjulnBANqzYU7rXB1Gqrj/Fb5WO4RUL1
         mrLA==
X-Gm-Message-State: AOAM530UKb8TtjgcEhCWZAw10joPAB2q1nt+5f8/r+RsLUnuzlhL38YV
        LhLITGIpB3uOS+ulowekxAuhyw25feHN7KzxfHQ=
X-Google-Smtp-Source: ABdhPJxSFc1uAxmWXYwh68l1H/HJH8mEvIn2b8J7aQFWuCZp99cHNrOri7Rr7B6aZOYmuUljw5ZO4gUKAZzb1BEUpN8=
X-Received: by 2002:a54:4f19:0:b0:325:338e:ff52 with SMTP id
 e25-20020a544f19000000b00325338eff52mr6959287oiy.98.1651484648570; Mon, 02
 May 2022 02:44:08 -0700 (PDT)
MIME-Version: 1.0
References: <YmwjUcTKyQNrrn2g@kili>
In-Reply-To: <YmwjUcTKyQNrrn2g@kili>
From:   Chuanhong Guo <gch981213@gmail.com>
Date:   Mon, 2 May 2022 17:43:56 +0800
Message-ID: <CAJsYDVJN8uZaH-YAk6vBiq845QBdvCkz_Cz9KxZrJ90x8PWqXA@mail.gmail.com>
Subject: Re: [PATCH] spi: mtk-snfi: preserve dma_mapping_error() error codes
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-spi@vger.kernel.org, linux-mediatek@lists.infradead.org,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi!

On Sat, Apr 30, 2022 at 1:42 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> Return -ENOMEM of there is a dma mapping error.  Do not return success.
>
> Fixes: 764f1b748164 ("spi: add driver for MTK SPI NAND Flash Interface")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Oops. Thanks for fixing that.
Reviewed-by: Chuanhong Guo <gch981213@gmail.com>
--
Regards,
Chuanhong Guo
