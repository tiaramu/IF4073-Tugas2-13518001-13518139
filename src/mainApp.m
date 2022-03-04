classdef mainApp < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure             matlab.ui.Figure
        FilteredImage3Label  matlab.ui.control.Label
        FilteredImage2Label  matlab.ui.control.Label
        FilteredImage1Label  matlab.ui.control.Label
        Image3Label          matlab.ui.control.Label
        Image2Label          matlab.ui.control.Label
        Image1Label          matlab.ui.control.Label
        ButterworthLabel     matlab.ui.control.Label
        OriginalLabel        matlab.ui.control.Label
        SelectModeLabel      matlab.ui.control.Label
        FilteredImageLabel   matlab.ui.control.Label
        GaussianLabel        matlab.ui.control.Label
        IdealLabel           matlab.ui.control.Label
        NoiseButton          matlab.ui.control.Button
        BrightenButton       matlab.ui.control.Button
        SharpenButton        matlab.ui.control.Button
        SmoothButton         matlab.ui.control.Button
        NewButton            matlab.ui.control.Button
        FrequencyDomainImageFilteringLabel  matlab.ui.control.Label
        AfterImageAxes_4     matlab.ui.control.UIAxes
        AfterImageAxes_5     matlab.ui.control.UIAxes
        AfterImageAxes_6     matlab.ui.control.UIAxes
        BeforeImageAxes_3    matlab.ui.control.UIAxes
        BeforeImageAxes_2    matlab.ui.control.UIAxes
        BeforeImageAxes_1    matlab.ui.control.UIAxes
        AfterImageAxes_3     matlab.ui.control.UIAxes
        AfterImageAxes_2     matlab.ui.control.UIAxes
        AfterImageAxes_1     matlab.ui.control.UIAxes
        BeforeImageAxes      matlab.ui.control.UIAxes
    end

    
    properties (Access = private)
        oriImage % Original image, meant to be processed
    end
    
    methods (Access = private)
        function uploadPhoto(app)
            [filename,filepath] = uigetfile({'*.jpg;*.tif;*.png;*.gif'}, 'Select File to Open');
            if ischar(filepath)
                fullname = [filepath, filename];
            end
            ImageFile = imread(fullname);
            imagesc(app.BeforeImageAxes,ImageFile);
            app.oriImage = ImageFile;

            app.NewButton.Enable = 'on';
        end
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            % Configure image axes
            app.BeforeImageAxes.Colormap = gray(256);
            axis(app.BeforeImageAxes, 'image');
            app.BeforeImageAxes.Visible = 'off';

            app.AfterImageAxes_1.Visible = 'off';
            app.AfterImageAxes_2.Visible = 'off';
            app.AfterImageAxes_3.Visible = 'off';
            app.AfterImageAxes_1.Colormap = gray(256);
            app.AfterImageAxes_2.Colormap = gray(256);
            app.AfterImageAxes_3.Colormap = gray(256);
            axis(app.AfterImageAxes_1, 'image');
            axis(app.AfterImageAxes_2, 'image');
            axis(app.AfterImageAxes_3, 'image');

            app.BeforeImageAxes_1.Visible = 'off';
            app.BeforeImageAxes_2.Visible = 'off';
            app.BeforeImageAxes_3.Visible = 'off';
            app.BeforeImageAxes_1.Colormap = gray(256);
            app.BeforeImageAxes_2.Colormap = gray(256);
            app.BeforeImageAxes_3.Colormap = gray(256);
            axis(app.BeforeImageAxes_1, 'image');
            axis(app.BeforeImageAxes_2, 'image');
            axis(app.BeforeImageAxes_3, 'image');

            app.AfterImageAxes_4.Visible = 'off';
            app.AfterImageAxes_5.Visible = 'off';
            app.AfterImageAxes_6.Visible = 'off';
            app.AfterImageAxes_4.Colormap = gray(256);
            app.AfterImageAxes_5.Colormap = gray(256);
            app.AfterImageAxes_6.Colormap = gray(256);
            axis(app.AfterImageAxes_4, 'image');
            axis(app.AfterImageAxes_5, 'image');
            axis(app.AfterImageAxes_6, 'image');

            app.NewButton.Enable = 'off';
        end

        % Button pushed function: NewButton
        function NewButtonPushed(app, event)
            cla(app.BeforeImageAxes);
            cla(app.BeforeImageAxes_1);
            cla(app.BeforeImageAxes_2);
            cla(app.BeforeImageAxes_3);
            cla(app.AfterImageAxes_1);
            cla(app.AfterImageAxes_2);
            cla(app.AfterImageAxes_3);
            cla(app.AfterImageAxes_4);
            cla(app.AfterImageAxes_5);
            cla(app.AfterImageAxes_6);
            app.BeforeImageAxes.Visible = 'off';
            app.BeforeImageAxes_1.Visible = 'off';
            app.BeforeImageAxes_2.Visible = 'off';
            app.BeforeImageAxes_3.Visible = 'off';
            app.AfterImageAxes_1.Visible = 'off';
            app.AfterImageAxes_2.Visible = 'off';
            app.AfterImageAxes_3.Visible = 'off';
            app.AfterImageAxes_4.Visible = 'off';
            app.AfterImageAxes_5.Visible = 'off';
            app.AfterImageAxes_6.Visible = 'off';

            app.OriginalLabel.Visible = 'off';
            app.FilteredImageLabel.Visible = 'off';
            app.IdealLabel.Visible = 'off';
            app.GaussianLabel.Visible = 'off';
            app.ButterworthLabel.Visible = 'off';

            app.Image1Label.Visible = 'off';
            app.FilteredImage1Label.Visible = 'off';
            app.Image2Label.Visible = 'off';
            app.FilteredImage2Label.Visible = 'off';
            app.Image3Label.Visible = 'off';
            app.FilteredImage3Label.Visible = 'off';

            app.NewButton.Enable = 'off';
            app.SmoothButton.Enable = 'on';
            app.SharpenButton.Enable = 'on';
            app.BrightenButton.Enable = 'on';
            app.NoiseButton.Enable = 'on';
        end

        % Button pushed function: SmoothButton
        function SmoothButtonPushed(app, event)
            % Input image
            uploadPhoto(app);

            % Call function
            img_i = ilpf(app.oriImage);
            img_g = glpf(app.oriImage);
            img_b = blpf(app.oriImage);

            % Output image
            imagesc(app.AfterImageAxes_1,img_i);
            imagesc(app.AfterImageAxes_2,img_g);
            imagesc(app.AfterImageAxes_3,img_b);

            app.OriginalLabel.Visible = 'on';
            app.IdealLabel.Visible = 'on';
            app.GaussianLabel.Visible = 'on';
            app.ButterworthLabel.Visible = 'on';

            app.SmoothButton.Enable = 'off';
            app.SharpenButton.Enable = 'off';
            app.BrightenButton.Enable = 'off';
            app.NoiseButton.Enable = 'off';
        end

        % Button pushed function: SharpenButton
        function SharpenButtonPushed(app, event)
            % Input image
            uploadPhoto(app);

            % Call function
            img_i = ihpf(app.oriImage);
            img_g = ghpf(app.oriImage);
            img_b = bhpf(app.oriImage);

            % Output image
            imagesc(app.AfterImageAxes_1,img_i);
            imagesc(app.AfterImageAxes_2,img_g);
            imagesc(app.AfterImageAxes_3,img_b);

            app.OriginalLabel.Visible = 'on';
            app.IdealLabel.Visible = 'on';
            app.GaussianLabel.Visible = 'on';
            app.ButterworthLabel.Visible = 'on';

            app.SmoothButton.Enable = 'off';
            app.SharpenButton.Enable = 'off';
            app.BrightenButton.Enable = 'off';
            app.NoiseButton.Enable = 'off';
        end

        % Button pushed function: BrightenButton
        function BrightenButtonPushed(app, event)
            % Input image
            uploadPhoto(app);

            % Call function
            img_i = addBrightnessF(app.oriImage);

            % Output image
            imagesc(app.AfterImageAxes_1,img_i);

            app.OriginalLabel.Visible = 'on';
            app.FilteredImageLabel.Visible = 'on';

            app.SmoothButton.Enable = 'off';
            app.SharpenButton.Enable = 'off';
            app.BrightenButton.Enable = 'off';
            app.NoiseButton.Enable = 'off';
        end

        % Button pushed function: NoiseButton
        function NoiseButtonPushed(app, event)
            % Input image -> defined
            % Call function
            [img_a, img_ia] = reduceNoiseA();
            [img_b, img_ib] = reduceNoiseB();
            [img_c, img_ic] = reduceNoiseC();
            
            % Output image -> defined, processed
            imagesc(app.BeforeImageAxes_1,img_a);
            imagesc(app.BeforeImageAxes_2,img_b);
            imagesc(app.BeforeImageAxes_3,img_c);

            imagesc(app.AfterImageAxes_4,img_ia);
            imagesc(app.AfterImageAxes_5,img_ib);
            imagesc(app.AfterImageAxes_6,img_ic);

            app.Image1Label.Visible = 'on';
            app.FilteredImage1Label.Visible = 'on';
            app.Image2Label.Visible = 'on';
            app.FilteredImage2Label.Visible = 'on';
            app.Image3Label.Visible = 'on';
            app.FilteredImage3Label.Visible = 'on';
            
            app.SmoothButton.Enable = 'off';
            app.SharpenButton.Enable = 'off';
            app.BrightenButton.Enable = 'off';
            app.NoiseButton.Enable = 'off';
            app.NewButton.Enable = 'on';
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.AutoResizeChildren = 'off';
            app.UIFigure.Position = [100 100 830 623];
            app.UIFigure.Name = 'Image Histograms';
            app.UIFigure.Resize = 'off';

            % Create BeforeImageAxes
            app.BeforeImageAxes = uiaxes(app.UIFigure);
            app.BeforeImageAxes.XTick = [];
            app.BeforeImageAxes.XTickLabel = {'[ ]'};
            app.BeforeImageAxes.YTick = [];
            app.BeforeImageAxes.Position = [180 234 225 156];

            % Create AfterImageAxes_1
            app.AfterImageAxes_1 = uiaxes(app.UIFigure);
            app.AfterImageAxes_1.XTick = [];
            app.AfterImageAxes_1.XTickLabel = {'[ ]'};
            app.AfterImageAxes_1.YTick = [];
            app.AfterImageAxes_1.Position = [442 234 225 156];

            % Create AfterImageAxes_2
            app.AfterImageAxes_2 = uiaxes(app.UIFigure);
            app.AfterImageAxes_2.XTick = [];
            app.AfterImageAxes_2.XTickLabel = {'[ ]'};
            app.AfterImageAxes_2.YTick = [];
            app.AfterImageAxes_2.Position = [181 40 225 156];

            % Create AfterImageAxes_3
            app.AfterImageAxes_3 = uiaxes(app.UIFigure);
            app.AfterImageAxes_3.XTick = [];
            app.AfterImageAxes_3.XTickLabel = {'[ ]'};
            app.AfterImageAxes_3.YTick = [];
            app.AfterImageAxes_3.Position = [442 40 225 156];

            % Create BeforeImageAxes_1
            app.BeforeImageAxes_1 = uiaxes(app.UIFigure);
            app.BeforeImageAxes_1.XTick = [];
            app.BeforeImageAxes_1.XTickLabel = {'[ ]'};
            app.BeforeImageAxes_1.YTick = [];
            app.BeforeImageAxes_1.Position = [43 234 225 156];

            % Create BeforeImageAxes_2
            app.BeforeImageAxes_2 = uiaxes(app.UIFigure);
            app.BeforeImageAxes_2.XTick = [];
            app.BeforeImageAxes_2.XTickLabel = {'[ ]'};
            app.BeforeImageAxes_2.YTick = [];
            app.BeforeImageAxes_2.Position = [303 234 225 156];

            % Create BeforeImageAxes_3
            app.BeforeImageAxes_3 = uiaxes(app.UIFigure);
            app.BeforeImageAxes_3.XTick = [];
            app.BeforeImageAxes_3.XTickLabel = {'[ ]'};
            app.BeforeImageAxes_3.YTick = [];
            app.BeforeImageAxes_3.Position = [563 234 225 156];

            % Create AfterImageAxes_6
            app.AfterImageAxes_6 = uiaxes(app.UIFigure);
            app.AfterImageAxes_6.XTick = [];
            app.AfterImageAxes_6.XTickLabel = {'[ ]'};
            app.AfterImageAxes_6.YTick = [];
            app.AfterImageAxes_6.Position = [563 40 225 156];

            % Create AfterImageAxes_5
            app.AfterImageAxes_5 = uiaxes(app.UIFigure);
            app.AfterImageAxes_5.XTick = [];
            app.AfterImageAxes_5.XTickLabel = {'[ ]'};
            app.AfterImageAxes_5.YTick = [];
            app.AfterImageAxes_5.Position = [303 40 225 156];

            % Create AfterImageAxes_4
            app.AfterImageAxes_4 = uiaxes(app.UIFigure);
            app.AfterImageAxes_4.XTick = [];
            app.AfterImageAxes_4.XTickLabel = {'[ ]'};
            app.AfterImageAxes_4.YTick = [];
            app.AfterImageAxes_4.Position = [43 40 225 156];

            % Create FrequencyDomainImageFilteringLabel
            app.FrequencyDomainImageFilteringLabel = uilabel(app.UIFigure);
            app.FrequencyDomainImageFilteringLabel.VerticalAlignment = 'top';
            app.FrequencyDomainImageFilteringLabel.FontName = 'Times New Roman';
            app.FrequencyDomainImageFilteringLabel.FontSize = 20;
            app.FrequencyDomainImageFilteringLabel.FontWeight = 'bold';
            app.FrequencyDomainImageFilteringLabel.Position = [262 573 308 31];
            app.FrequencyDomainImageFilteringLabel.Text = 'Frequency Domain Image Filtering';

            % Create NewButton
            app.NewButton = uibutton(app.UIFigure, 'push');
            app.NewButton.ButtonPushedFcn = createCallbackFcn(app, @NewButtonPushed, true);
            app.NewButton.Position = [303 433 225 22];
            app.NewButton.Text = 'New image';

            % Create SmoothButton
            app.SmoothButton = uibutton(app.UIFigure, 'push');
            app.SmoothButton.ButtonPushedFcn = createCallbackFcn(app, @SmoothButtonPushed, true);
            app.SmoothButton.Position = [180 505 225 22];
            app.SmoothButton.Text = 'Smooth';

            % Create SharpenButton
            app.SharpenButton = uibutton(app.UIFigure, 'push');
            app.SharpenButton.ButtonPushedFcn = createCallbackFcn(app, @SharpenButtonPushed, true);
            app.SharpenButton.Position = [442 505 225 22];
            app.SharpenButton.Text = 'Sharpen';

            % Create BrightenButton
            app.BrightenButton = uibutton(app.UIFigure, 'push');
            app.BrightenButton.ButtonPushedFcn = createCallbackFcn(app, @BrightenButtonPushed, true);
            app.BrightenButton.Position = [180 470 225 22];
            app.BrightenButton.Text = 'Brighten';

            % Create NoiseButton
            app.NoiseButton = uibutton(app.UIFigure, 'push');
            app.NoiseButton.ButtonPushedFcn = createCallbackFcn(app, @NoiseButtonPushed, true);
            app.NoiseButton.Position = [442 469 225 22];
            app.NoiseButton.Text = 'Remove noise';

            % Create IdealLabel
            app.IdealLabel = uilabel(app.UIFigure);
            app.IdealLabel.Visible = 'off';
            app.IdealLabel.Position = [539 389 31 22];
            app.IdealLabel.Text = 'Ideal';

            % Create GaussianLabel
            app.GaussianLabel = uilabel(app.UIFigure);
            app.GaussianLabel.Visible = 'off';
            app.GaussianLabel.Position = [267 196 56 22];
            app.GaussianLabel.Text = 'Gaussian';

            % Create FilteredImageLabel
            app.FilteredImageLabel = uilabel(app.UIFigure);
            app.FilteredImageLabel.Visible = 'off';
            app.FilteredImageLabel.Position = [513 389 82 22];
            app.FilteredImageLabel.Text = 'Filtered Image';

            % Create SelectModeLabel
            app.SelectModeLabel = uilabel(app.UIFigure);
            app.SelectModeLabel.HorizontalAlignment = 'center';
            app.SelectModeLabel.VerticalAlignment = 'top';
            app.SelectModeLabel.FontName = 'Times New Roman';
            app.SelectModeLabel.FontSize = 16;
            app.SelectModeLabel.FontWeight = 'bold';
            app.SelectModeLabel.Position = [363 537 107 21];
            app.SelectModeLabel.Text = 'Select Mode';

            % Create OriginalLabel
            app.OriginalLabel = uilabel(app.UIFigure);
            app.OriginalLabel.Visible = 'off';
            app.OriginalLabel.Position = [270 389 47 22];
            app.OriginalLabel.Text = 'Original';

            % Create ButterworthLabel
            app.ButterworthLabel = uilabel(app.UIFigure);
            app.ButterworthLabel.Visible = 'off';
            app.ButterworthLabel.Position = [521 196 67 22];
            app.ButterworthLabel.Text = 'Butterworth';

            % Create Image1Label
            app.Image1Label = uilabel(app.UIFigure);
            app.Image1Label.HorizontalAlignment = 'center';
            app.Image1Label.Visible = 'off';
            app.Image1Label.Position = [135 389 49 22];
            app.Image1Label.Text = 'Image 1';

            % Create Image2Label
            app.Image2Label = uilabel(app.UIFigure);
            app.Image2Label.HorizontalAlignment = 'center';
            app.Image2Label.Visible = 'off';
            app.Image2Label.Position = [392 389 49 22];
            app.Image2Label.Text = 'Image 2';

            % Create Image3Label
            app.Image3Label = uilabel(app.UIFigure);
            app.Image3Label.HorizontalAlignment = 'center';
            app.Image3Label.Visible = 'off';
            app.Image3Label.Position = [652 389 49 22];
            app.Image3Label.Text = 'Image 3';

            % Create FilteredImage1Label
            app.FilteredImage1Label = uilabel(app.UIFigure);
            app.FilteredImage1Label.HorizontalAlignment = 'center';
            app.FilteredImage1Label.Visible = 'off';
            app.FilteredImage1Label.Position = [114 196 92 22];
            app.FilteredImage1Label.Text = 'Filtered Image 1';

            % Create FilteredImage2Label
            app.FilteredImage2Label = uilabel(app.UIFigure);
            app.FilteredImage2Label.HorizontalAlignment = 'center';
            app.FilteredImage2Label.Visible = 'off';
            app.FilteredImage2Label.Position = [370 196 92 22];
            app.FilteredImage2Label.Text = 'Filtered Image 2';

            % Create FilteredImage3Label
            app.FilteredImage3Label = uilabel(app.UIFigure);
            app.FilteredImage3Label.HorizontalAlignment = 'center';
            app.FilteredImage3Label.Visible = 'off';
            app.FilteredImage3Label.Position = [630 196 92 22];
            app.FilteredImage3Label.Text = 'Filtered Image 3';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = mainApp

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            % Execute the startup function
            runStartupFcn(app, @startupFcn)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end